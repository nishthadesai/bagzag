import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/widget/show_message.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';

import '../../../data/my_data/feed_story_data.dart';
import '../../../generated/l10n.dart';
import '../../../widget/app_text_filed.dart';

@RoutePage()
class StoryViewPage extends StatefulWidget {
  final FeedStoryData data;
  const StoryViewPage({super.key, required this.data});

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  TextEditingController messageController = TextEditingController();
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      widget.data.video,
    );
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.black,
      body: buildView(height),
    );
  }

  Widget buildView(double height) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        widget.data.isVideo
            ? Center(
                child: SizedBox(
                  height: _controller.value.aspectRatio < 1 ? height : null,
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : widget.data.storyPic is String
                ? Image.asset(
                    height: height,
                    fit: BoxFit.fill,
                    widget.data.storyPic,
                    width: double.infinity,
                  )
                : Image.file(
                    height: height,
                    fit: BoxFit.fill,
                    widget.data.storyPic,
                    width: double.infinity,
                  ),
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              AppColor.black.withOpacity(0),
              AppColor.black.withOpacity(0.90)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        Positioned(
          top: 43.r,
          left: 19.r,
          right: 8.r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget.data.profilePic)),
                      shape: BoxShape.circle,
                    ),
                    height: 40.r,
                    width: 40.w,
                  ),
                  10.horizontalSpace,
                  Column(
                    children: [
                      Text(
                        widget.data.name,
                        style: textMedium.copyWith(
                            fontSize: 16.spMin, color: AppColor.white),
                      ),
                      Text(
                        "2 min ago",
                        style: textRegular.copyWith(
                            fontSize: 12.spMin, color: AppColor.white),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    Assets.imageStudioMenu,
                    color: AppColor.white,
                    height: 16.r,
                    width: 4.w,
                  ),
                  9.horizontalSpace,
                  GestureDetector(
                    onTap: () {
                      appRouter.maybePop();
                    },
                    child: Icon(
                      Icons.close,
                      color: AppColor.white,
                      size: 25.r,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 15.r,
          bottom: 1.r,
          right: 17.r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.productName,
                style: textMedium.copyWith(
                    fontSize: 18.spMin, color: AppColor.white),
              ),
              6.verticalSpace,
              ReadMoreText(
                "${widget.data.desc}\n ",
                trimMode: TrimMode.Line,
                trimLines: 2,
                colorClickableText: Colors.black,
                trimCollapsedText: S.of(context).seeMore,
                trimExpandedText: S.of(context).seeLess,
                lessStyle: textRegular.copyWith(
                    fontSize: 12.spMin, color: AppColor.black),
                moreStyle: textRegular.copyWith(
                    fontSize: 12.spMin, color: AppColor.black),
                style: textRegular.copyWith(
                    overflow: TextOverflow.visible,
                    fontSize: 12.spMin,
                    color: AppColor.grayColor),
              ),
              12.verticalSpace,
              AppTextField(
                controller: messageController,
                onSubmit: (value) {
                  if (messageController.text.isNotEmpty) {
                    showMessage(S.of(context).messageSentSuccessfully);
                    messageController.text = "";
                  }
                },
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                keyboardAction: TextInputAction.send,
                contentPadding: EdgeInsets.only(left: 21),
                borderRadius: BorderRadius.circular(5).r,
                fillColor: AppColor.white,
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (messageController.text.isNotEmpty) {
                      FocusScope.of(context).unfocus();
                      showMessage(S.of(context).messageSentSuccessfully);
                      messageController.text = "";
                    }
                  },
                  child: Icon(
                    Icons.send,
                    color: AppColor.black,
                  ),
                ),
                filled: true,
                height: 50.r,
                label: '',
                hint: S.of(context).sendMessage,
                hintStyle: textRegular.copyWith(
                  fontSize: 16.spMin,
                  color: AppColor.grayColor,
                ),
              ),
              15.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
