import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../data/my_data/recent_view_data.dart';
import '../../../generated/l10n.dart';
import '../../../router/app_router.dart';

@RoutePage()
class InfluencerProfilePage extends StatefulWidget {
  const InfluencerProfilePage({super.key});

  @override
  State<InfluencerProfilePage> createState() => _InfluencerProfilePageState();
}

class _InfluencerProfilePageState extends State<InfluencerProfilePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverLayoutBuilder(
              builder: (context, constraints) {
                final isScrolled = constraints.scrollOffset > 400;
                return SliverAppBar(
                  backgroundColor: AppColor.white,
                  expandedHeight: height < 600 ? 310 : 462,
                  stretch: true,
                  pinned: true,
                  snap: false,
                  floating: true,
                  scrolledUnderElevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Image.asset(
                          Assets.imageProfileFullView,
                          height: 337.r,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          height: 337.r,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  AppColor.black.withOpacity(0.20),
                                  AppColor.black.withOpacity(0.40)
                                ]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 189, left: 14).r,
                          height: 36.r,
                          width: 36.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3).r,
                              border: Border.all(
                                  color: AppColor.white, width: 1.5)),
                          child: Image.asset(
                            Assets.imageStudioPost1ProfilePic,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 240, left: 14).r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).michaeleLusiada,
                                style: textSemiBold.copyWith(
                                    fontSize: 16.spMin, color: AppColor.white),
                              ),
                              2.verticalSpace,
                              Text(
                                "@mich123",
                                style: textMedium.copyWith(
                                    fontSize: 14.spMin,
                                    color: AppColor.grayColor,
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                                  top: 243, left: height < 600 ? 340 : 266)
                              .r,
                          width: 92.w,
                          height: 34.r,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5).r,
                              color: AppColor.pinkColor),
                          child: Center(
                            child: Text(
                              S.of(context).follow,
                              style: textMedium.copyWith(
                                  fontSize: 16.spMin, color: AppColor.white),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                                  top: 303, left: 15, right: 15, bottom: 0)
                              .r,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.black.withOpacity(0.20),
                                offset: const Offset(
                                  0,
                                  4,
                                ),
                                blurRadius: 13.r,
                                spreadRadius: -3.r,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                            borderRadius: BorderRadius.circular(5).r,
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              18.verticalSpace,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "458",
                                        style: textMedium.copyWith(
                                            fontSize: 14.spMin,
                                            color: AppColor.black),
                                      ),
                                      Text(
                                        S.of(context).followers,
                                        style: textRegular.copyWith(
                                            fontSize: 14.spMin,
                                            color: AppColor.grayColor),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "800",
                                        style: textMedium.copyWith(
                                            fontSize: 14.spMin,
                                            color: AppColor.black),
                                      ),
                                      Text(
                                        S.of(context).followings,
                                        style: textRegular.copyWith(
                                            fontSize: 14.spMin,
                                            color: AppColor.grayColor),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "500",
                                        style: textMedium.copyWith(
                                            fontSize: 14.spMin,
                                            color: AppColor.black),
                                      ),
                                      Text(
                                        S.of(context).post,
                                        style: textRegular.copyWith(
                                            fontSize: 14.spMin,
                                            color: AppColor.grayColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ).wrapPaddingOnly(left: 24, right: 43),
                              9.verticalSpace,
                              Divider(
                                color: AppColor.grayColor.withOpacity(0.50),
                              ),
                              9.verticalSpace,
                              ReadMoreText(
                                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout \n ",
                                trimMode: TrimMode.Line,
                                trimLines: 3,
                                colorClickableText: Colors.pink,
                                trimCollapsedText: S.of(context).seeMore,
                                trimExpandedText: S.of(context).seeLess,
                                lessStyle: textRegular.copyWith(
                                    fontSize: 12.spMin,
                                    color: AppColor.pinkColor),
                                moreStyle: textRegular.copyWith(
                                    fontSize: 12.spMin, color: AppColor.black),
                                style: textRegular.copyWith(
                                    overflow: TextOverflow.visible,
                                    fontSize: 12.spMin,
                                    color: AppColor.grayColor),
                              ).wrapPaddingOnly(left: 16, right: 15),
                              7.verticalSpace,
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      appRouter.maybePop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 17.r,
                      color: isScrolled ? AppColor.black : AppColor.white,
                    ),
                  ),
                );
              },
            )
          ];
        },
        body: buildView(height),
      ),
    );
  }

  Widget buildView(double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).recommendedProducts,
          style: textMedium.copyWith(fontSize: 16.spMin, color: AppColor.black),
        ),
        17.verticalSpace,
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recentViewBuilderDataList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: height < 600 ? 265.r : 236.r,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1),
            itemBuilder: (context, index) {
              RecentViewData recentViewData = recentViewBuilderDataList[index];
              return Container(
                color: AppColor.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: height < 600 ? 210.w : 172.r,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5).r,
                            child: Center(child: recentViewData.image),
                          ),
                          ValueListenableBuilder(
                            valueListenable: recentViewData.isLiked,
                            builder: (context, value, child) {
                              return GestureDetector(
                                onTap: () {
                                  recentViewData.isLiked.value =
                                      !recentViewData.isLiked.value;
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 5, top: 9),
                                  alignment: Alignment.topRight,
                                  height: 24.r,
                                  width: 24.w,
                                  decoration: BoxDecoration(
                                    color: AppColor.grayColor.withOpacity(0.20),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Image.asset(value == false
                                            ? Assets.imageHeart
                                            : Assets.imagePinkHeart)
                                        .wrapPaddingAll(5),
                                  ),
                                ),
                              );
                            },
                          ),
                          recentViewData.offer != ""
                              ? Positioned(
                                  left: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(2).r,
                                            bottomRight: Radius.circular(2).r),
                                        color: AppColor.pinkColor),
                                    child: Text(
                                      recentViewData.offer,
                                      style: textMedium.copyWith(
                                          fontSize: 8.spMin,
                                          color: AppColor.white),
                                    ).wrapPaddingAll(4),
                                    alignment: Alignment.topLeft,
                                  ).wrapPaddingTop(10),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ).wrapPaddingTop(10),
                    6.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: height < 600 ? 200.r : 172.r,
                          child: Text(
                            recentViewData.productName,
                            style: textLight.copyWith(fontSize: 12.spMin),
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                        5.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              Assets.imageStar,
                              height: 11.r,
                              width: 11.w,
                            ),
                            3.horizontalSpace,
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: recentViewData.rating,
                                    style: textMedium.copyWith(
                                        fontSize: 10.spMin,
                                        color: AppColor.black),
                                  ),
                                  TextSpan(
                                    text: " | 256  ",
                                    style: textRegular.copyWith(
                                        fontSize: 10.spMin,
                                        color: AppColor.grayColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        5.verticalSpace,
                        recentViewData.tag != ""
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2).r,
                                  color: recentViewData.tag == "Bestseller"
                                      ? AppColor.pinkColor.withOpacity(0.20)
                                      : AppColor.grayColor.withOpacity(0.19),
                                ),
                                child: Text(
                                  recentViewData.tag,
                                  style: textMedium.copyWith(
                                      fontSize: 9.spMin,
                                      color: recentViewData.tag == "Bestseller"
                                          ? AppColor.pinkColor
                                          : AppColor.grayColor),
                                ).wrapPaddingSymmetric(
                                    vertical: 2, horizontal: 8),
                              )
                            : Container(
                                color: AppColor.transparent,
                                child: Text(
                                  "",
                                ).wrapPaddingSymmetric(
                                    vertical: 2, horizontal: 8),
                              ),
                        4.verticalSpace,
                        Container(
                          width: height < 600 ? 210.r : 172.r,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "\$${recentViewData.finalPrice}",
                                    style: textMedium.copyWith(
                                        fontSize: 12.spMin,
                                        color: AppColor.black),
                                  ),
                                  5.horizontalSpace,
                                  Text(
                                    "\$${recentViewData.discount}",
                                    style: textRegular.copyWith(
                                        fontSize: 12.spMin,
                                        color: AppColor.grayColor,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ],
                              ),
                              Image.asset(
                                Assets.imageBestsellerCart,
                                height: 18.r,
                                width: 18.w,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).wrapPaddingHorizontal(9),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ).wrapPaddingAll(15);
  }
}
