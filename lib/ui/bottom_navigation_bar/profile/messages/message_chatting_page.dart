import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/data/my_data/messages_data.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

@RoutePage()
class MessageChattingPage extends StatefulWidget {
  final MessagesData messagesData;
  final int index;
  const MessageChattingPage(
      {super.key, required this.messagesData, required this.index});

  @override
  State<MessageChattingPage> createState() => _MessageChattingPageState();
}

class _MessageChattingPageState extends State<MessageChattingPage> {
  TextEditingController messageController = TextEditingController();
  String path = "";
  ValueNotifier<bool> isRecording = ValueNotifier(false);
  ValueNotifier<String> audioPath = ValueNotifier("");
  AudioRecorder audioRecord = AudioRecorder();
  AudioPlayer audioPlayer = AudioPlayer();

  onMessageSubmit() {
    if (messageController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      messageChatMap[widget.index].add(MessageChatData(
          isSender: ValueNotifier(true),
          msg: messageController.text,
          time: S.of(context).justNow));
      messageController.text = "";
    }
  }

  onAudioSubmit() {
    if (audioPath.value.isNotEmpty) {
      FocusScope.of(context).unfocus();
      messageChatMap[widget.index].add(MessageChatData(
          isSender: ValueNotifier(true),
          msg: "Play",
          time: S.of(context).justNow));
      messageController.text = "";
    }
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        final Directory appDocDir = await getApplicationDocumentsDirectory();
        await audioRecord.start(RecordConfig(),
            path: p.join(appDocDir.path, "MyRecording.wav"));
        print("Path is:::::::::: ${p.join(appDocDir.path)}");
        isRecording.value = true;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> stopRecording() async {
    try {
      path = (await audioRecord.stop())!;
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
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        child: buildAppBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: buildView(height),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AppTextField(
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
                      color: AppColor.black,
                    ),
                  ),
                  10.horizontalSpace,
                  GestureDetector(
                    onTap: () {
                      onMessageSubmit();
                    },
                    child: Icon(
                      Icons.send,
                      color: AppColor.black,
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
      ),
    );
  }

  Widget buildAppBar() {
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
              color: Colors.black,
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
            style:
                textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
          ),
        ],
      ),
      showTitle: true,
      centerTitle: false,
      backgroundColor: AppColor.white,
    );
  }

  Widget buildView(double height) {
    return messageChatMap[widget.index]?.length == 0
        ? Column(
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
          )
        : Column(
            children: [
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: isRecording,
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: messageChatMap[widget.index]?.length,
                      itemBuilder: (BuildContext context, int index) {
                        // print(messageChatMap[widget.index][index]);
                        MessageChatData messageChatData =
                            messageChatMap[widget.index]?[index];
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
                                        borderRadius:
                                            BorderRadius.circular(3).r,
                                        child: Image.asset(
                                          widget.messagesData.dp,
                                          height: 25.r,
                                          width: 25.w,
                                        ),
                                      ).wrapPaddingRight(8),
                                Flexible(
                                  child: Container(
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
                                        color: messageChatData.isSender.value
                                            ? AppColor.black
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
                                                    color: AppColor.white),
                                            backgroundColor: AppColor.black,
                                            playIcon: Icon(
                                              Icons.play_arrow,
                                              color: AppColor.white,
                                            ),
                                            pauseIcon: Icon(
                                              Icons.pause,
                                              color: AppColor.white,
                                            ),
                                            activeSliderColor: AppColor.white,
                                            stopDownloadingIcon: Icon(
                                              Icons.close,
                                              color: AppColor.white,
                                            ),
                                            notActiveSliderColor:
                                                AppColor.black,
                                            circlesColor: AppColor.transparent,
                                          )
                                        : Text(
                                            messageChatData.msg,
                                            style: textRegular.copyWith(
                                                fontSize: 16.spMin,
                                                color: messageChatData
                                                        .isSender.value
                                                    ? AppColor.white
                                                    : AppColor.black),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ).wrapPaddingOnly(
                                            top: 10,
                                            bottom: 9,
                                            left: 20,
                                            right: 20),
                                  ).wrapPaddingLeft(
                                      messageChatData.isSender.value ? 113 : 0),
                                ),
                              ],
                            ),
                            5.verticalSpace,
                            Text(
                              messageChatData.time,
                              style: textRegular.copyWith(
                                  fontSize: 12.spMin,
                                  color: AppColor.grayColor),
                            ).wrapPaddingLeft(height < 600 ? 40 : 34),
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

  @override
  void dispose() {
    messageController.dispose();
    audioRecord.dispose();
    audioPlayer.dispose();
    super.dispose();
  }
}
