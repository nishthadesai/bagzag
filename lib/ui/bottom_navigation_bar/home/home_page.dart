import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/core/db/app_db.dart';
import 'package:flutter_demo_structure/data/my_data/bestseller_data.dart';
import 'package:flutter_demo_structure/data/my_data/home_cat_list_data.dart';
import 'package:flutter_demo_structure/data/my_data/recent_view_data.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../values/colors.dart';
import '../../../values/style.dart';
import '../../../widget/base_app_bar.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        child: buildAppBar(height),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: buildView(height),
    );
  }

  Widget buildAppBar(double height) {
    return BaseAppBar(
      leadingIcon: true,
      leadingWidget: GestureDetector(
        onTap: () {
          appDB.isLogin = false;
          appRouter.replaceAll([WalkThroughRoute()]);
        },
        child: Image.asset(
          Assets.imageLogo,
          height: 28.r,
          width: 29.w,
        ).wrapPaddingOnly(top: 6, left: 15),
      ),
      action: [
        GestureDetector(
          onTap: () {
            appRouter.push(AppBarSearchRoute());
          },
          child: Image.asset(
            Assets.imageSearch,
            height: 24.r,
            width: 24.r,
          ),
        ),
        15.horizontalSpace,
        GestureDetector(
          onTap: () {
            appRouter.push(FavoritesRoute());
          },
          child: Image.asset(
            Assets.imageHeart,
            height: 24.r,
            width: 24.r,
          ),
        ),
        13.horizontalSpace,
        badges.Badge(
          badgeStyle: badges.BadgeStyle(badgeColor: AppColor.white),
          position: BadgePosition.topEnd(
              top: height < 600 ? 8 : 3, end: height < 600 ? -6 : -4),
          badgeContent: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.pinkColor, shape: BoxShape.circle),
              height: 9.r,
              width: 9.w,
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Image.asset(
              Assets.imageNotification,
              height: 24.r,
              width: 24.r,
            ),
          ),
        ),
        13.horizontalSpace,
        Image.asset(
          Assets.imageBuy,
          height: 24.r,
          width: 24.r,
        ),
        16.horizontalSpace,
      ],
      backgroundColor: AppColor.white,
    );
  }

  Widget buildView(double height) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          18.verticalSpace,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: S.of(context).hi,
                  style: textLight.copyWith(
                      fontSize: 18.spMin, color: AppColor.grayColor),
                ),
                TextSpan(
                  text: " David",
                  style: textSemiBold.copyWith(
                      fontSize: 18.spMin, color: AppColor.black),
                ),
              ],
            ),
          ).wrapPaddingLeft(15),
          Text(
            S.of(context).newCollectionFromBagzag,
            style: textRegular.copyWith(
                fontSize: 16.spMin, color: AppColor.grayColor),
          ).wrapPaddingLeft(15),
          15.verticalSpace,
          buildCategoriesList(height),
          12.verticalSpace,
          buildBestSellerProductList(height),
          20.verticalSpace,
          buildRecentView(height),
          Container(
            color: AppColor.grayColor.withOpacity(0.10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.verticalSpace,
                buildBuyersLovedList(height),
                16.verticalSpace,
                buildFindThingsYouLoveList(height),
                60.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoriesList(double height) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            appRouter.push(BrowseCategoriesRoute());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).categories,
                style: textMedium,
              ),
              Row(
                children: [
                  Text(
                    S.of(context).viewMore,
                    style: textRegular.copyWith(
                        fontSize: 14.spMin, color: AppColor.grayColor),
                  ),
                  5.horizontalSpace,
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColor.grayColor,
                    size: 9.r,
                  ),
                ],
              ),
            ],
          ).wrapPaddingHorizontal(15),
        ),
        8.verticalSpace,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              catList.length,
              (index) {
                HomeCatListData catData = catList[index];
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5).r,
                          color: AppColor.grayColor.withOpacity(0.20)),
                      child: Container(
                        height: 69.r,
                        width: 78.r,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(3).r,
                        ),
                      ).wrapPaddingOnly(left: 2, right: 2, bottom: 27, top: 2),
                      margin: EdgeInsets.only(top: 10, right: 7, left: 7),
                    ),
                    Positioned(
                      bottom: height < 600 ? 18 : 26,
                      top: -1,
                      child: catData.image,
                    ),
                    Positioned(
                      bottom: height < 600 ? 2 : 6,
                      child: Text(
                        catData.catName,
                        style: textRegular.copyWith(
                            color: AppColor.black, fontSize: 12.spMin),
                      ),
                    ),
                  ],
                ).wrapPaddingLeft(index == 0 ? 5 : 0);
              },
            ),
          ),
        ),
        9.verticalSpace,
      ],
    );
  }

  Widget buildBestSellerProductList(double height) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).bestsellerProduct,
              style: textMedium,
            ),
            Row(
              children: [
                Text(
                  S.of(context).viewMore,
                  style: textRegular.copyWith(
                      fontSize: 14.spMin, color: AppColor.grayColor),
                ),
                5.horizontalSpace,
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.grayColor,
                  size: 9.r,
                ),
              ],
            ),
          ],
        ).wrapPaddingHorizontal(15),
        12.verticalSpace,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              bestSellerListData.length,
              (index) {
                BestsellerData bestsellerData = bestSellerListData[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5).r,
                          child: Image.asset(
                            bestsellerData.image,
                            height: 180.r,
                            width: height < 600 ? 160.r : 131.r,
                            fit: BoxFit.fill,
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: bestsellerData.isLiked,
                          builder: (context, value, child) {
                            return GestureDetector(
                              onTap: () {
                                bestsellerData.isLiked.value =
                                    !bestsellerData.isLiked.value;
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 5, top: 5),
                                alignment: Alignment.topRight,
                                height: 24.r,
                                width: 24.w,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
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
                        bestsellerData.offer != ""
                            ? Positioned(
                                left: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(2).r,
                                          bottomRight: Radius.circular(2).r),
                                      color: AppColor.pinkColor),
                                  child: Text(
                                    bestsellerData.offer,
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
                    6.verticalSpace,
                    Container(
                      width: height < 600 ? 160.r : 131.r,
                      child: Text(
                        bestsellerData.productName,
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
                                text: bestsellerData.rating,
                                style: textMedium.copyWith(
                                    fontSize: 10.spMin, color: AppColor.black),
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
                    bestsellerData.tag != ""
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2).r,
                              color: bestsellerData.tag == "Bestseller"
                                  ? AppColor.pinkColor.withOpacity(0.20)
                                  : AppColor.grayColor.withOpacity(0.19),
                            ),
                            child: Text(
                              bestsellerData.tag,
                              style: textMedium.copyWith(
                                  fontSize: 9.spMin,
                                  color: bestsellerData.tag == "Bestseller"
                                      ? AppColor.pinkColor
                                      : AppColor.grayColor),
                            ).wrapPaddingSymmetric(vertical: 2, horizontal: 8),
                          )
                        : Container(
                            color: AppColor.transparent,
                            child: Text(
                              "",
                            ).wrapPaddingSymmetric(vertical: 2, horizontal: 8),
                          ),
                    4.verticalSpace,
                    Container(
                      width: height < 600 ? 160.r : 132.r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "\$${bestsellerData.finalPrice}",
                                style: textMedium.copyWith(
                                    fontSize: 12.spMin, color: AppColor.black),
                              ),
                              5.horizontalSpace,
                              Text(
                                "\$${bestsellerData.discount}",
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
                ).wrapPaddingOnly(right: 15, left: index == 0 ? 13 : 0);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget buildRecentView(double height) {
    return Container(
      height: height < 600 ? 560.r : 520.r,
      color: AppColor.grayColor.withOpacity(0.13),
      child: Stack(
        children: [
          Container(
            height: 450.r,
            color: AppColor.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).recentlyViewedByYou,
                style: textMedium.copyWith(
                    fontSize: 16.spMin, color: AppColor.white),
              ),
              Row(
                children: [
                  Text(
                    S.of(context).viewMore,
                    style: textRegular.copyWith(
                        fontSize: 14.spMin, color: AppColor.white),
                  ),
                  5.horizontalSpace,
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColor.white,
                    size: 9.r,
                  ),
                ],
              ),
            ],
          ).wrapPaddingOnly(top: 15, left: 15, right: 16),
          Positioned.fill(
            top: 58.r,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withOpacity(0.12),
                    offset: Offset(0, 5),
                    blurRadius: 16.r,
                    spreadRadius: 2.r,
                  ),
                ],
                borderRadius: BorderRadius.circular(5).r,
                color: AppColor.grayColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5).r,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recentViewBuilderDataList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: height < 600 ? 255.r : 235.r,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1),
                  itemBuilder: (context, index) {
                    RecentViewData recentViewData =
                        recentViewBuilderDataList[index];
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
                                        margin:
                                            EdgeInsets.only(right: 5, top: 9),
                                        alignment: Alignment.topRight,
                                        height: 24.r,
                                        width: 24.w,
                                        decoration: BoxDecoration(
                                          color: AppColor.grayColor
                                              .withOpacity(0.20),
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
                                                  topRight:
                                                      Radius.circular(2).r,
                                                  bottomRight:
                                                      Radius.circular(2).r),
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
                          ),
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
                                        borderRadius:
                                            BorderRadius.circular(2).r,
                                        color:
                                            recentViewData.tag == "Bestseller"
                                                ? AppColor.pinkColor
                                                    .withOpacity(0.20)
                                                : AppColor.grayColor
                                                    .withOpacity(0.19),
                                      ),
                                      child: Text(
                                        recentViewData.tag,
                                        style: textMedium.copyWith(
                                            fontSize: 9.spMin,
                                            color: recentViewData.tag ==
                                                    "Bestseller"
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                              decoration:
                                                  TextDecoration.lineThrough),
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
            ).wrapPaddingSymmetric(horizontal: 15),
          ),
        ],
      ),
    );
  }

  Widget buildBuyersLovedList(double height) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).buyersMostLoved,
              style: textMedium,
            ),
            Row(
              children: [
                Text(
                  S.of(context).viewMore,
                  style: textRegular.copyWith(
                      fontSize: 14.spMin, color: AppColor.grayColor),
                ),
                5.horizontalSpace,
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.grayColor,
                  size: 9.r,
                ),
              ],
            ),
          ],
        ).wrapPaddingHorizontal(15),
        11.verticalSpace,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              2,
              (index) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColor.darkGrayColor.withOpacity(0.90),
                    borderRadius: BorderRadius.circular(5).r,
                  ),
                  child: Row(
                    children: [
                      5.horizontalSpace,
                      Image.asset(
                        Assets.imageBuyer,
                        height: 109.r,
                        width: 101.w,
                      ),
                      7.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).looseTexturedTshirt,
                            style: textMedium.copyWith(fontSize: 14.spMin),
                          ),
                          2.verticalSpace,
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
                                      text: "4.5",
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
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2).r,
                              color: AppColor.grayColor.withOpacity(0.19),
                            ),
                            child: Text(
                              S.of(context).freeShipping,
                              style: textMedium.copyWith(
                                  fontSize: 9.spMin, color: AppColor.grayColor),
                            ).wrapPaddingSymmetric(vertical: 2, horizontal: 8),
                          ),
                          7.verticalSpace,
                          Container(
                            width: height < 600 ? 190.r : 150.r,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "\$119.99",
                                      style: textMedium.copyWith(
                                          fontSize: 12.spMin,
                                          color: AppColor.black),
                                    ),
                                    5.horizontalSpace,
                                    Text(
                                      "\$159.99",
                                      style: textRegular.copyWith(
                                          fontSize: 12.spMin,
                                          color: AppColor.grayColor,
                                          decoration:
                                              TextDecoration.lineThrough),
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
                      ).wrapPaddingOnly(top: 16, bottom: 12, right: 13),
                    ],
                  ),
                ).wrapPaddingOnly(right: 12, left: index == 0 ? 15 : 0);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFindThingsYouLoveList(double height) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).findThingsYoullLove,
              style: textMedium,
            ),
            Row(
              children: [
                Text(
                  S.of(context).viewMore,
                  style: textRegular.copyWith(
                      fontSize: 14.spMin, color: AppColor.grayColor),
                ),
                5.horizontalSpace,
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.grayColor,
                  size: 9.r,
                ),
              ],
            ),
          ],
        ).wrapPaddingHorizontal(15),
        12.verticalSpace,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              bestSellerListData.length,
              (index) {
                BestsellerData bestsellerData = bestSellerListData[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5).r,
                          child: Image.asset(
                            bestsellerData.image,
                            height: 180.r,
                            width: height < 600 ? 160.r : 131.r,
                            fit: BoxFit.fill,
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: bestsellerData.isLiked,
                          builder: (context, value, child) {
                            return GestureDetector(
                              onTap: () {
                                bestsellerData.isLiked.value =
                                    !bestsellerData.isLiked.value;
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 5, top: 5),
                                alignment: Alignment.topRight,
                                height: 24.r,
                                width: 24.w,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
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
                        bestsellerData.offer != ""
                            ? Positioned(
                                left: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(2).r,
                                          bottomRight: Radius.circular(2).r),
                                      color: AppColor.pinkColor),
                                  child: Text(
                                    bestsellerData.offer,
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
                    6.verticalSpace,
                    Container(
                      width: height < 600 ? 160.r : 131.r,
                      child: Text(
                        bestsellerData.productName,
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
                                text: bestsellerData.rating,
                                style: textMedium.copyWith(
                                    fontSize: 10.spMin, color: AppColor.black),
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
                    bestsellerData.tag != ""
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2).r,
                              color: bestsellerData.tag == "Bestseller"
                                  ? AppColor.pinkColor.withOpacity(0.20)
                                  : AppColor.grayColor.withOpacity(0.19),
                            ),
                            child: Text(
                              bestsellerData.tag,
                              style: textMedium.copyWith(
                                  fontSize: 9.spMin,
                                  color: bestsellerData.tag == "Bestseller"
                                      ? AppColor.pinkColor
                                      : AppColor.grayColor),
                            ).wrapPaddingSymmetric(vertical: 2, horizontal: 8),
                          )
                        : Container(
                            color: AppColor.transparent,
                            child: Text(
                              "",
                            ).wrapPaddingSymmetric(vertical: 2, horizontal: 8),
                          ),
                    4.verticalSpace,
                    Container(
                      width: height < 600 ? 160.r : 132.r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "\$${bestsellerData.finalPrice}",
                                style: textMedium.copyWith(
                                    fontSize: 12.spMin, color: AppColor.black),
                              ),
                              5.horizontalSpace,
                              Text(
                                "\$${bestsellerData.discount}",
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
                ).wrapPaddingOnly(right: 15, left: index == 0 ? 13 : 0);
              },
            ),
          ),
        )
      ],
    );
  }
}
