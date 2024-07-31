import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/annotations.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_demo_structure/data/my_data/messages_data.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../../data/my_data/message_chat_data.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../../values/colors.dart';
import '../../../../values/style.dart';
import '../../../../widget/app_text_filed.dart';
import '../../../../widget/base_app_bar.dart';

enum Reaction { like, laugh, love, smile, sad, shocked, angry, none }

@RoutePage()
class MessageChattingPage extends StatefulWidget {
  final MessagesData messagesData;
  final int index;
  const MessageChattingPage(
      {super.key, required this.messagesData, required this.index});

  @override
  State<MessageChattingPage> createState() => _MessageChattingPageState();
}

class _MessageChattingPageState extends State<MessageChattingPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController _animationController;
  late SpringSimulation springSimulation;
  var items = <Item>[];
  static final random = Random();
  TextEditingController messageController = TextEditingController();
  TextEditingController textController = TextEditingController();
  ValueNotifier<int> hoveredMessageIndex = ValueNotifier<int>(-1);
  int numberOfItem = 20;
  ValueNotifier<bool> isRecording = ValueNotifier(false);
  ValueNotifier<bool> isEmojiPopupVisible = ValueNotifier(false);
  ValueNotifier<bool> isEmojiKeyboard = ValueNotifier(false);
  ValueNotifier<String> audioPath = ValueNotifier("");
  AudioRecorder audioRecord = AudioRecorder();
  AudioPlayer audioPlayer = AudioPlayer();
  double? containerHeight;
  final List<GlobalKey> chatContainerKeys = [];
  final List<ReactionElement> reactions = [
    ReactionElement(Reaction.like, "👍🏻"),
    ReactionElement(Reaction.laugh, "😆"),
    ReactionElement(Reaction.love, "😍"),
    ReactionElement(Reaction.smile, "😊"),
    ReactionElement(Reaction.sad, "😞"),
    ReactionElement(Reaction.shocked, "😲"),
    ReactionElement(Reaction.angry, "😡"),
  ];
  @override
  void dispose() {
    messageController.dispose();
    textController.dispose();
    hoveredMessageIndex.dispose();
    audioRecord.dispose();
    audioPlayer.dispose();
    isRecording.dispose();
    isEmojiKeyboard.dispose();
    isEmojiPopupVisible.dispose();
    audioPath.dispose();
    animationController.dispose();
    _animationController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: double.infinity,
    );
    springSimulation = SpringSimulation(
      SpringDescription(mass: 0.5, stiffness: 100, damping: 20),
      150,
      0,
      0,
    );
  }

  onMessageSubmit() {
    if (messageController.text.isNotEmpty) {
      messageChatMap[widget.index].add(
        MessageChatData(
          isSender: ValueNotifier(true),
          msg: messageController.text,
          time: S.of(context).justNow,
        ),
      );
      messageController.text = "";
    }
  }

  onAudioSubmit() {
    if (audioPath.value.isNotEmpty) {
      messageChatMap[widget.index].add(
        MessageChatData(
          isSender: ValueNotifier(true),
          msg: "Play",
          time: S.of(context).justNow,
        ),
      );
      messageController.text = "";
    }
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        final Directory appDocDir = await getApplicationDocumentsDirectory();
        await audioRecord.start(RecordConfig(),
            path: p.join(appDocDir.path, "MyRecording.wav"));

        isRecording.value = true;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> stopRecording() async {
    try {
      String path = (await audioRecord.stop())!;
      isRecording.value = false;
      audioPath.value = path;
      onAudioSubmit();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> playRecording() async {
    try {
      Source urlSource = UrlSource(audioPath.value);
      await audioPlayer.play(urlSource);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: isDarkMode ? AppColor.black : AppColor.white,
      appBar: PreferredSize(
        child: buildAppBar(isDarkMode),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Stack(
        children: [
          buildView(height, isDarkMode),
          ...buildItems(),
        ],
      ),
      bottomNavigationBar: buildBottomNavigation(isDarkMode),
    );
  }

  Widget buildAppBar(bool isDarkMode) {
    return BaseAppBar(
      titleWidget: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              appRouter.maybePop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 17.r,
              color: isDarkMode ? AppColor.white : AppColor.black,
            ),
          ),
          10.horizontalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(3).r,
            child: Image.asset(
              widget.messagesData.dp,
              height: 22.r,
              width: 22.w,
            ),
          ),
          10.horizontalSpace,
          Text(
            widget.messagesData.name,
            style: textMedium.copyWith(
              fontSize: 20.spMin,
              color: isDarkMode ? AppColor.white : AppColor.black,
            ),
          ),
        ],
      ),
      showTitle: true,
      centerTitle: false,
      backgroundColor: isDarkMode ? AppColor.black : AppColor.white,
    );
  }

  Widget buildView(double height, bool isDarkMode) {
    return messageChatMap[widget.index]?.length == 0
        ? noMsgView()
        : GestureDetector(
            onTap: () {
              isEmojiKeyboard.value = false;
              isEmojiPopupVisible.value = false;
              // chatContainerKeys.removeAt(0);
            },
            child: chatView(isDarkMode),
          );
  }

  Widget buildBottomNavigation(bool isDarkMode) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ValueListenableBuilder(
        valueListenable: isEmojiKeyboard,
        builder: (context, value, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppTextField(
                onTap: () {
                  if (isEmojiKeyboard.value) {
                    isEmojiKeyboard.value = !isEmojiKeyboard.value;
                  }
                },
                controller: messageController,
                onSubmit: (value) {
                  onMessageSubmit();
                },
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                keyboardAction: TextInputAction.send,
                contentPadding: EdgeInsets.only(left: 21),
                borderRadius: BorderRadius.circular(5).r,
                suffixIcon: ValueListenableBuilder(
                  valueListenable: isRecording,
                  builder: (context, value, child) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            value ? stopRecording() : startRecording();
                          },
                          child: Icon(
                            value ? Icons.stop : Icons.mic_outlined,
                            color: isDarkMode ? AppColor.white : AppColor.black,
                          ),
                        ),
                        10.horizontalSpace,
                        GestureDetector(
                          onTap: () {
                            onMessageSubmit();
                            print("object");
                          },
                          child: Icon(
                            Icons.send,
                            color: isDarkMode ? AppColor.white : AppColor.black,
                          ),
                        ),
                        17.horizontalSpace,
                      ],
                    );
                  },
                ),
                height: 50.r,
                label: '',
                hint: S.of(context).writeHere,
                hintStyle: textRegular.copyWith(
                  fontSize: 16.spMin,
                  color: AppColor.grayColor,
                ),
              ).wrapPaddingOnly(left: 15, right: 15, bottom: 20),
              value
                  ? ValueListenableBuilder(
                      valueListenable: hoveredMessageIndex,
                      builder: (context, value, child) {
                        return EmojiPicker(
                          onEmojiSelected: (category, emoji) {
                            setState(() {
                              MessageChatData messageChatData =
                                  messageChatMap[widget.index]?[value];
                              isEmojiPopupVisible.value = false;
                              isEmojiKeyboard.value = false;
                              _animationController
                                  .animateWith(springSimulation);
                              messageChatData.emoji != ""
                                  ? messageChatData.emoji = textController.text
                                  : null;
                              textController.text = "";
                            });
                          },
                          textEditingController: textController,
                          config: Config(
                            height: 300.r,
                            emojiViewConfig: EmojiViewConfig(
                              emojiSizeMax: 28 * (Platform.isIOS ? 1.20 : 1.0),
                            ),
                            skinToneConfig: const SkinToneConfig(),
                          ),
                        );
                      },
                    )
                  : SizedBox.shrink()
            ],
          );
        },
      ),
    );
  }

  Widget noMsgView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Image.asset(
          Assets.imageNoMsg,
          height: 150.r,
          width: 150.w,
        )),
        5.verticalSpace,
        Text(
          S.of(context).noMessageYet,
          style: textMedium.copyWith(fontSize: 16.spMin),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget chatView(bool isDarkMode) {
    return Column(
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: isRecording,
            builder: (context, value, child) {
              return ListView.builder(
                itemCount: messageChatMap[widget.index]?.length,
                itemBuilder: (BuildContext context, int index) {
                  MessageChatData messageChatData =
                      messageChatMap[widget.index]?[index];
                  final key = GlobalKey();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: messageChatData.isSender.value
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: messageChatData.isSender.value
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          messageChatData.isSender.value
                              ? SizedBox.shrink()
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(3).r,
                                  child: Image.asset(
                                    widget.messagesData.dp,
                                    height: 25.r,
                                    width: 25.w,
                                  ),
                                ).wrapPaddingRight(8),
                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: isEmojiPopupVisible,
                              builder: (context, value, child) {
                                return Stack(
                                  alignment: messageChatData.isSender.value
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  children: [
                                    GestureDetector(
                                      onLongPress: () {
                                        setState(() {
                                          hoveredMessageIndex.value = index;
                                          isEmojiPopupVisible.value =
                                              !isEmojiPopupVisible.value;
                                          if (chatContainerKeys.length == 0) {
                                            chatContainerKeys.add(key);
                                          } else {
                                            chatContainerKeys.removeAt(0);
                                            chatContainerKeys.add(key);
                                          }
                                          getChatContainerPositions(index);
                                        });
                                      },
                                      child: Container(
                                        key: key,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10).r,
                                              topRight: Radius.circular(10).r,
                                              bottomRight: Radius.circular(
                                                  messageChatData.isSender.value
                                                      ? 0
                                                      : 10),
                                              bottomLeft: Radius.circular(
                                                  messageChatData.isSender.value
                                                      ? 10
                                                      : 0),
                                            ),
                                            color:
                                                messageChatData.isSender.value
                                                    ? !isDarkMode
                                                        ? AppColor.black
                                                        : AppColor.white
                                                    : AppColor.grayColor
                                                        .withOpacity(0.37)),
                                        child: messageChatData.msg == "Play"
                                            ? VoiceMessageView(
                                                controller: VoiceController(
                                                  audioSrc: audioPath.value,
                                                  isFile: true,
                                                  onPause: () {},
                                                  onPlaying: () {},
                                                  onComplete: () {},
                                                  maxDuration:
                                                      Duration(seconds: 60),
                                                ),
                                                innerPadding: 8,
                                                cornerRadius: 20,
                                                counterTextStyle:
                                                    textMedium.copyWith(
                                                  fontSize: 10.spMin,
                                                  color: isDarkMode
                                                      ? AppColor.white
                                                      : AppColor.black,
                                                ),
                                                backgroundColor: isDarkMode
                                                    ? AppColor.white
                                                    : AppColor.black,
                                                playIcon: Icon(
                                                  Icons.play_arrow,
                                                  color: isDarkMode
                                                      ? AppColor.black
                                                      : AppColor.white,
                                                ),
                                                pauseIcon: Icon(
                                                  Icons.pause,
                                                  color: AppColor.white,
                                                ),
                                                activeSliderColor: isDarkMode
                                                    ? AppColor.black
                                                    : AppColor.white,
                                                stopDownloadingIcon: Icon(
                                                  Icons.close,
                                                  color: isDarkMode
                                                      ? AppColor.white
                                                      : AppColor.black,
                                                ),
                                                notActiveSliderColor: isDarkMode
                                                    ? AppColor.white
                                                    : AppColor.black,
                                                circlesColor:
                                                    AppColor.transparent,
                                              )
                                            : Text(
                                                messageChatData.msg,
                                                style: textRegular.copyWith(
                                                    fontSize: 16.spMin,
                                                    color: messageChatData
                                                            .isSender.value
                                                        ? isDarkMode
                                                            ? AppColor.black
                                                            : AppColor.white
                                                        : isDarkMode
                                                            ? AppColor.white
                                                            : AppColor.black),
                                                softWrap: true,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.visible,
                                              ).wrapPaddingOnly(
                                                top: 10,
                                                bottom: 9,
                                                left: 20,
                                                right: 20),
                                      ).wrapPaddingOnly(
                                        left: messageChatData.isSender.value
                                            ? 80
                                            : 0,
                                        right: messageChatData.isSender.value ==
                                                false
                                            ? 80
                                            : 0,
                                      ),
                                    ),
                                    ValueListenableBuilder<int>(
                                      valueListenable: hoveredMessageIndex,
                                      builder: (context, hoveredIndex, child) {
                                        return hoveredIndex == index &&
                                                isEmojiPopupVisible.value
                                            ? Positioned(
                                                right: messageChatData
                                                        .isSender.value
                                                    ? 0
                                                    : null,
                                                bottom: 2,
                                                child: Container(
                                                  height: 35.r,
                                                  width: 262.w,
                                                  decoration: BoxDecoration(
                                                    color: messageChatData
                                                            .isSender.value
                                                        ? isDarkMode
                                                            ? AppColor.black
                                                            : AppColor.white
                                                        : isDarkMode
                                                            ? AppColor.white
                                                            : AppColor.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                                50)
                                                            .r,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Flexible(
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount:
                                                              reactions.length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            ReactionElement
                                                                element =
                                                                reactions[
                                                                    index];
                                                            return AnimationConfiguration
                                                                .staggeredList(
                                                              position: index,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          375),
                                                              child:
                                                                  SlideAnimation(
                                                                verticalOffset:
                                                                    15 +
                                                                        index *
                                                                            15,
                                                                child:
                                                                    FadeInAnimation(
                                                                  child: Center(
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          messageChatData.emoji =
                                                                              element.icon;
                                                                          isEmojiPopupVisible.value =
                                                                              false;
                                                                          _animationController
                                                                              .animateWith(springSimulation);
                                                                        });
                                                                      },
                                                                      onLongPress:
                                                                          () {
                                                                        messageChatData.emoji =
                                                                            element.icon;
                                                                        makeItems(messageChatData.emoji ??
                                                                            "");
                                                                        // chatContainerKeys
                                                                        //     .removeAt(0);
                                                                        isEmojiPopupVisible.value =
                                                                            false;
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        reactions[index]
                                                                            .icon,
                                                                        style: textBold.copyWith(
                                                                            fontSize:
                                                                                22.spMin),
                                                                      ).wrapPaddingLeft(
                                                                              8),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(3).r,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            isEmojiKeyboard
                                                                    .value =
                                                                !isEmojiKeyboard
                                                                    .value;
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: messageChatData
                                                                    .isSender
                                                                    .value
                                                                ? isDarkMode
                                                                    ? AppColor
                                                                        .white
                                                                    : AppColor
                                                                        .black
                                                                : isDarkMode
                                                                    ? AppColor
                                                                        .black
                                                                    : AppColor
                                                                        .white,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : SizedBox.shrink();
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      5.verticalSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: messageChatData.isSender.value
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Text(
                            messageChatData.time,
                            style: textRegular.copyWith(
                                fontSize: 12.spMin, color: AppColor.grayColor),
                          ),
                          5.horizontalSpace,
                          messageChatData.emoji != null
                              ? GestureDetector(
                                  child: hoveredMessageIndex.value == index
                                      ? AnimatedBuilder(
                                          animation: _animationController,
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Transform.translate(
                                              offset: Offset(
                                                0,
                                                -_animationController.value,
                                              ),
                                              child: Text(
                                                messageChatData.emoji ?? "",
                                                style: textRegular.copyWith(
                                                  fontSize: 15.spMin,
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : Text(
                                          messageChatData.emoji ?? "",
                                          style: textRegular.copyWith(
                                            fontSize: 15.spMin,
                                          ),
                                        ),
                                  onTap: () {
                                    setState(() {
                                      messageChatData.emoji = null;
                                      textController.text = "";
                                    });
                                  },
                                )
                              : SizedBox.shrink(),
                        ],
                      ).wrapPaddingLeft(1.sh < 600 ? 40 : 34),
                      7.verticalSpace,
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    ).wrapPaddingHorizontal(15);
  }

  void getChatContainerPositions(int index) {
    for (var key in chatContainerKeys) {
      final RenderBox renderBox =
          key.currentContext?.findRenderObject() as RenderBox;
      final Offset position = renderBox.localToGlobal(Offset.zero);
      containerHeight = position.dy;
      print('Chat Container Top Position: $containerHeight');
    }
  }

  void makeItems(String image) {
    setState(() {
      items.clear();
      for (int i = 0; i < numberOfItem; i++) {
        items.add(Item(
            random.nextDouble() * 40 + 1,
            Alignment(random.nextDouble() * 2 - 1, random.nextDouble() * 2 - 1),
            image));
      }
    });
    animationController.reset();
    animationController.forward();
  }

  List<Widget> buildItems() {
    return items.map((item) {
      var tween = Tween<Offset>(
              begin: Offset(Random().nextDouble() * 0.01, 0),
              end: Offset(0, Random().nextDouble() * -1 - 1))
          .chain(CurveTween(curve: Curves.linear));
      return Container(
        height: containerHeight,
        child: SlideTransition(
          position: animationController.drive(tween),
          child: AnimatedAlign(
            alignment: item._alignment,
            duration: Duration(seconds: 10),
            child: AnimatedContainer(
              duration: Duration(seconds: 10),
              width: item._size,
              height: item._size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Text(item.image),
            ),
          ),
        ),
      );
    }).toList();
  }
}

class ReactionElement {
  final Reaction reaction;
  final String icon;

  ReactionElement(this.reaction, this.icon);
}

class Item {
  static final random = Random();
  final double _size;
  String image = "";

  final Alignment _alignment;
  Item(this._size, this._alignment, this.image);
}
