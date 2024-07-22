import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../data/my_data/studio_data.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../values/colors.dart';
import '../../../values/style.dart';
import '../../../widget/base_app_bar.dart';

class StudioPage extends StatefulWidget {
  const StudioPage({super.key});

  @override
  State<StudioPage> createState() => _StudioPageState();
}

class _StudioPageState extends State<StudioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grayColor.withOpacity(0.13),
      appBar: PreferredSize(
        child: buildAppBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: buildView(),
    );
  }

  Widget buildAppBar() {
    return BaseAppBar(
      action: [
        Image.asset(
          Assets.imageAddNewPost,
          height: 20.r,
          width: 20.w,
        ).wrapPaddingRight(10),
      ],
      titleWidget: Text(
        S.of(context).studio,
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
      showTitle: true,
      centerTitle: false,
      backgroundColor: AppColor.white,
    );
  }

  Widget buildView() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          studioDataList.length,
          (index) {
            StudioData studioData = studioDataList[index];
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
                          GestureDetector(
                            onTap: () {
                              appRouter.push(InfluencerProfileRoute());
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3).r,
                              child: Image.asset(
                                studioData.profileImage,
                                height: 36.r,
                                width: 36.w,
                              ),
                            ),
                          ),
                          9.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      appRouter.push(InfluencerProfileRoute());
                                    },
                                    child: Text(
                                      studioData.userName,
                                      style: textMedium.copyWith(
                                          fontSize: 15.spMin),
                                    ),
                                  ),
                                  2.horizontalSpace,
                                  Icon(
                                    Icons.circle,
                                    size: 7.r,
                                    color: AppColor.grayColor,
                                  ),
                                  10.horizontalSpace,
                                  ValueListenableBuilder(
                                    valueListenable: studioData.isFollowed,
                                    builder: (context, value, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          studioData.isFollowed.value =
                                              !studioData.isFollowed.value;
                                        },
                                        child: Text(
                                          value == false
                                              ? S.of(context).follow
                                              : S.of(context).following,
                                          style: textRegular.copyWith(
                                              fontSize: 14.spMin,
                                              color: AppColor.pinkColor),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              3.verticalSpace,
                              Text(
                                studioData.lastSeen,
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
                            studioData.currentIndex.value = index;
                          },
                        ),
                        items: studioData.postImage.map((i) {
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
                      Positioned(
                        right: 0,
                        child: Container(
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.only(bottom: 13, right: 17).r,
                          height: 25.r,
                          decoration: BoxDecoration(
                            color: AppColor.black.withOpacity(0.50),
                            borderRadius: BorderRadius.circular(3).r,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.imageBuy,
                                height: 14.r,
                                width: 15.w,
                                color: AppColor.white,
                              ),
                              5.horizontalSpace,
                              Text(
                                S.of(context).shopProducts,
                                style: textMedium.copyWith(
                                    fontSize: 10.spMin, color: AppColor.white),
                              ),
                            ],
                          ).wrapPaddingSymmetric(vertical: 5, horizontal: 7),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: studioData.currentIndex,
                        builder: (context, value, child) {
                          return new DotsIndicator(
                            dotsCount: 4,
                            position: value,
                            decorator: DotsDecorator(
                              color: AppColor.white,
                              activeColor: AppColor.black,
                              activeSize: Size(10.w, 10.r),
                              size: Size(10.w, 10.r),
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
                        valueListenable: studioData.isLiked,
                        builder: (context, value, child) {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  studioData.isLiked.value =
                                      !studioData.isLiked.value;
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
                              Image.asset(
                                Assets.imageStudioChat,
                                height: 18.r,
                                width: 20.w,
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
                            valueListenable: studioData.isSaved,
                            builder: (context, value, child) {
                              return GestureDetector(
                                onTap: () {
                                  studioData.isSaved.value =
                                      !studioData.isSaved.value;
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
                    studioData.desc,
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimCollapsedText: 'See more',
                    trimExpandedText: 'See less',
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
      ).wrapPaddingBottom(40),
    );
  }
}
