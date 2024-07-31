import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readmore/readmore.dart';

import '../../../data/my_data/feed_comments_data.dart';
import '../../../data/my_data/feed_posts_data.dart';
import '../../../data/my_data/feed_story_data.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../router/app_router.dart';
import '../../../values/app_class.dart';
import '../../../values/colors.dart';
import '../../../values/style.dart';
import '../../../widget/app_text_filed.dart';
import '../../../widget/base_app_bar.dart';
import '../../../widget/show_message.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  TextEditingController messageController = TextEditingController();
  XFile? image;
  String? path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        child: buildAppBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: RefreshIndicator(
        child: buildView(),
        onRefresh: () async {
          setState(() {});
        },
      ),
    );
  }

  Widget buildAppBar() {
    return BaseAppBar(
      showTitle: true,
      centerTitle: false,
      backgroundColor: AppColor.white,
      titleWidget: Text(
        S.of(context).feed,
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
    );
  }

  Widget buildView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildStoryList(image),
          21.verticalSpace,
          buildFeedPosts(),
          50.verticalSpace,
        ],
      ),
    );
  }

  Widget buildStoryList(XFile? image) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          feedStoryList.length,
          (index) {
            FeedStoryData data = feedStoryList[index];
            return Container(
              height: 104.r,
              width: 82.w,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  // data.storyPic is String
                  //     ?
                  ClipRRect(
                    child: Image.asset(
                      fit: BoxFit.fill,
                      data.storyPic[0].story,
                      height: 100.r,
                      width: 77.w,
                    ),
                    borderRadius: BorderRadius.circular(7).r,
                  ),
                  // : ClipRRect(
                  //     child: Image.file(
                  //       fit: BoxFit.fill,
                  //       data.storyPic[0].story,
                  //       height: 100.r,
                  //       width: 77.w,
                  //     ),
                  //     borderRadius: BorderRadius.circular(7).r,
                  //   ),
                  GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        if (data.storyPic !=
                            Assets.imageStudioPost1ProfilePic) {
                          appRouter.push(StoryViewRoute(data: data));
                        }
                      } else {
                        appRouter.push(StoryViewRoute(data: data));
                      }
                    },
                    child: Container(
                      height: 100.r,
                      width: 77.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(7).r,
                            bottomLeft: Radius.circular(7).r),
                        gradient: LinearGradient(
                            colors: [
                              AppColor.black.withOpacity(0),
                              AppColor.black,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 12.r,
                      left: 18.r,
                      right: 8.r,
                      child: Text(
                        data.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: textRegular.copyWith(
                            fontSize: 10.spMin, color: AppColor.white),
                      )),
                  index == 0
                      ? Positioned(
                          bottom: 35,
                          left: 26,
                          child: GestureDetector(
                            onTap: () {
                              _openCamera(image);
                            },
                            child: Image.asset(
                              Assets.imageAddStory,
                              height: 18.r,
                              width: 18.w,
                            ),
                          ),
                        )
                      : Positioned(
                          top: 5,
                          left: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(data.profilePic)),
                              shape: BoxShape.circle,
                            ),
                            height: 19.r,
                            width: 19.w,
                          ),
                        ),
                  data.isVideo
                      ? Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            Assets.imagePlay,
                            height: 17.r,
                            width: 17.w,
                          ),
                        )
                      : Text(""),
                ],
              ),
            ).wrapPaddingOnly(left: index == 0 ? 15 : 0, right: 12);
          },
        ),
      ),
    );
  }

  Widget buildFeedPosts() {
    return Column(
      children: List.generate(
        feedPostDataList.length,
        (index) {
          FeedPostData feedData = feedPostDataList[index];
          return Container(
            color: AppColor.white,
            child: Column(
              children: [
                index == 0 ? 1.verticalSpace : 15.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3).r,
                          child: Image.asset(
                            feedData.profileImage,
                            height: 36.r,
                            width: 36.w,
                          ),
                        ),
                        9.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: feedData.userName,
                                  style: textMedium.copyWith(
                                      fontSize: 15.spMin,
                                      color: AppColor.black)),
                              TextSpan(
                                  text: " Posted ",
                                  style: textRegular.copyWith(
                                      fontSize: 15.spMin,
                                      color: AppColor.grayColor)),
                              TextSpan(
                                  text: feedData.products.toString(),
                                  style: textMedium.copyWith(
                                      fontSize: 15.spMin,
                                      color: AppColor.black)),
                              TextSpan(
                                  text: " Products ",
                                  style: textRegular.copyWith(
                                      fontSize: 15.spMin,
                                      color: AppColor.grayColor)),
                            ])),
                            3.verticalSpace,
                            Text(
                              feedData.lastSeen,
                              style: textRegular.copyWith(
                                  fontSize: 12.spMin,
                                  color: AppColor.grayColor),
                            )
                          ],
                        ),
                      ],
                    ),
                    Image.asset(
                      Assets.imageStudioMenu,
                      height: 16.r,
                      width: 4.w,
                    )
                  ],
                ).wrapPaddingHorizontal(15),
                16.verticalSpace,
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        reverse: false,
                        height: 213.r,
                        padEnds: false,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          feedData.currentIndex.value = index;
                        },
                      ),
                      items: feedData.postImage.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              child: Image.asset(
                                '$i',
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    if (feedData.isNew)
                      Positioned(
                        left: 0,
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(bottom: 13, left: 17).r,
                          height: 25.r,
                          decoration: BoxDecoration(
                            color: AppColor.black.withOpacity(0.50),
                            borderRadius: BorderRadius.circular(3).r,
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).likeNew,
                              style: textMedium.copyWith(
                                  fontSize: 12.spMin, color: AppColor.white),
                            ).wrapPaddingSymmetric(vertical: 3, horizontal: 14),
                          ),
                        ),
                      ),
                    ValueListenableBuilder(
                      valueListenable: feedData.currentIndex,
                      builder: (context, value, child) {
                        return new DotsIndicator(
                          dotsCount: 4,
                          position: value,
                          decorator: DotsDecorator(
                            spacing: EdgeInsets.only(right: 5).r,
                            color: AppColor.white,
                            activeColor: AppColor.black,
                            activeSize: Size(7.w, 7.r),
                            size: Size(7.w, 7.r),
                          ),
                        ).wrapPaddingBottom(7);
                      },
                    ),
                  ],
                ),
                19.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: feedData.isLiked,
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                feedData.isLiked.value =
                                    !feedData.isLiked.value;
                              },
                              child: Image.asset(
                                value == false
                                    ? Assets.imageUnlike
                                    : Assets.imageLike,
                                height: 18.r,
                                width: 20.w,
                              ),
                            ),
                            14.horizontalSpace,
                            Text(
                              value == true ? "27" : "26",
                              style: textRegular.copyWith(
                                  fontSize: 14.spMin, color: AppColor.black),
                            ),
                            26.horizontalSpace,
                            GestureDetector(
                              onTap: () {
                                buildMessageBottomSheet();
                              },
                              child: Image.asset(
                                Assets.imageStudioChat,
                                height: 18.r,
                                width: 20.w,
                              ),
                            ),
                            12.horizontalSpace,
                            Text(
                              "30",
                              style: textRegular.copyWith(
                                  fontSize: 14.spMin, color: AppColor.black),
                            ),
                          ],
                        );
                      },
                    ),
                    Row(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: feedData.isSaved,
                          builder: (context, value, child) {
                            return GestureDetector(
                              onTap: () {
                                feedData.isSaved.value =
                                    !feedData.isSaved.value;
                              },
                              child: Image.asset(
                                value == false
                                    ? Assets.imageBookmark
                                    : Assets.imageBookmarkFilled,
                                height: 20.r,
                                width: 16.w,
                              ),
                            );
                          },
                        ),
                        19.horizontalSpace,
                        Image.asset(
                          Assets.imageSend,
                          height: 19.r,
                          width: 19.w,
                        ),
                      ],
                    ),
                  ],
                ).wrapPaddingHorizontal(15),
                10.verticalSpace,
                ReadMoreText(
                  feedData.desc,
                  trimMode: TrimMode.Line,
                  trimLines: 2,
                  colorClickableText: Colors.pink,
                  trimCollapsedText: S.of(context).seeMore,
                  trimExpandedText: S.of(context).seeLess,
                  lessStyle: textRegular.copyWith(
                      fontSize: 12.spMin, color: AppColor.pinkColor),
                  moreStyle: textRegular.copyWith(
                      fontSize: 12.spMin, color: AppColor.black),
                  style: textRegular.copyWith(
                      fontSize: 12.spMin, color: AppColor.grayColor),
                ).wrapPaddingHorizontal(15),
                7.verticalSpace,
              ],
            ),
          ).wrapPaddingBottom(10);
        },
      ),
    );
  }

  Future buildMessageBottomSheet() {
    return showModalBottomSheet(
      useSafeArea: true,
      isDismissible: true,
      showDragHandle: true,
      enableDrag: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(14).r, bottom: Radius.circular(14).r),
      ),
      backgroundColor: AppColor.white,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).comments30,
                  style: textMedium.copyWith(
                      fontSize: 20.spMin, color: AppColor.black),
                ),
                11.verticalSpace,
                Container(
                  height: 410.r,
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        feedCommentsList.length,
                        (index) {
                          FeedCommentsData data = feedCommentsList[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                  data.image,
                                  height: 41.r,
                                  width: 41.w,
                                ),
                                borderRadius: BorderRadius.circular(3).r,
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data.name,
                                          style: textMedium.copyWith(
                                            fontSize: 16.spMin,
                                            color: AppColor.black,
                                          ),
                                        ),
                                        Text(
                                          data.time,
                                          style: textRegular.copyWith(
                                              fontSize: 14.spMin,
                                              color: AppColor.grayColor),
                                        ),
                                      ],
                                    ),
                                    2.verticalSpace,
                                    Text(
                                      data.Comment,
                                      maxLines: 3,
                                      softWrap: false,
                                      style: textRegular.copyWith(
                                        fontSize: 12.spMin,
                                        color: AppColor.grayColor,
                                      ),
                                    ).wrapPaddingRight(25)
                                  ],
                                ),
                              ),
                            ],
                          ).wrapPaddingBottom(10);
                        },
                      ),
                    ),
                  ),
                ),
                40.verticalSpace,
                AppTextField(
                  controller: messageController,
                  onSubmit: (value) {
                    if (messageController.text.isNotEmpty) {
                      feedCommentsList.insertAll(0, [
                        FeedCommentsData(
                            image: Assets.imageStudioPost1ProfilePic,
                            name: "David Macro",
                            Comment: messageController.text,
                            time: "Just Now")
                      ]);
                      showMessage(S.of(context).messageSentSuccessfully);
                      messageController.text = "";
                    }
                  },
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  keyboardAction: TextInputAction.send,
                  contentPadding: EdgeInsets.only(left: 21),
                  borderRadius: BorderRadius.circular(5).r,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (messageController.text.isNotEmpty) {
                        feedCommentsList.addAll([
                          FeedCommentsData(
                              image: Assets.imageStudioPost1ProfilePic,
                              name: "David Macro",
                              Comment: messageController.text,
                              time: "Just Now")
                        ]);
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
                  height: 50.r,
                  label: '',
                  hint: S.of(context).sendMessage,
                  hintStyle: textRegular.copyWith(
                    fontSize: 16.spMin,
                    color: AppColor.grayColor,
                  ),
                ),
                26.verticalSpace,
              ],
            ).wrapPaddingOnly(left: 16, right: 12),
          ),
        );
      },
    );
  }

  Future<void> _openCamera(XFile? image) async {
    AppClass().showLoading(true);
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.camera);
    AppClass().showLoading(false);
    if (image != null) {
      path = image.path;
      await appRouter.push(CreateStoryRoute(path: '$path'));
    } else {
      print('No image selected.');
    }
  }
}
