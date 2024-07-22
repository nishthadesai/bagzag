import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/my_data/favorite_store_data.dart';
import '../../../data/my_data/recent_view_data.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../router/app_router.dart';
import '../../../values/colors.dart';
import '../../../values/style.dart';
import '../../../widget/base_app_bar.dart';

@RoutePage()
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
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
    );
  }

  Widget buildAppBar() {
    return BaseAppBar(
      leadingIcon: true,
      leadingWidget: GestureDetector(
        onTap: () {
          appRouter.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 17.r,
        ),
      ),
      titleWidget: Text(
        S.of(context).favorites,
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
      action: [
        Image.asset(
          Assets.imageSearch,
          height: 20.r,
          width: 20.r,
        ).wrapPaddingOnly(left: 11, top: 12, bottom: 12, right: 12),
      ],
      showTitle: true,
      centerTitle: true,
      backgroundColor: AppColor.white,
    );
  }

  Widget buildView(double height) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: BorderDirectional(
                  top: BorderSide(
                    color: AppColor.grayColor.withOpacity(0.30),
                  ),
                  bottom:
                      BorderSide(color: AppColor.grayColor.withOpacity(0.30)))),
          child: TabBar(
            indicatorColor: AppColor.black,
            indicatorWeight: 4,
            unselectedLabelStyle: textRegular.copyWith(
                fontSize: 16.spMin, color: AppColor.grayColor),
            labelStyle:
                textMedium.copyWith(fontSize: 16.spMin, color: AppColor.black),
            controller: tabController,
            tabs: [
              Tab(
                child: Text(
                  S.of(context).store,
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).products,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              buildStoreView(height),
              buildProductsView(height),
            ],
            controller: tabController,
          ),
        ),
      ],
    );
  }

  Widget buildStoreView(double height) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          3,
          (index) {
            RecentViewData recentViewData = recentViewBuilderDataList[index];
            FavoriteStoreData favoriteStoreData = favoriteStoreDataList[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: AppColor.grayColor.withOpacity(0.20),
                          offset: Offset(0, 1),
                          blurRadius: 5.r,
                          spreadRadius: 0),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4).r,
                    child: Image.asset(
                      favoriteStoreData.image,
                      fit: BoxFit.fill,
                      height: 154.r,
                      width: double.infinity,
                    ),
                  ),
                ),
                8.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          favoriteStoreData.storeName,
                          maxLines: 1,
                          softWrap: false,
                          style: textRegular.copyWith(
                              fontSize: 16.spMin, color: AppColor.black),
                        ),
                        5.verticalSpace,
                        Text(
                          favoriteStoreData.storeAddress,
                          maxLines: 1,
                          softWrap: false,
                          style: textRegular.copyWith(
                              fontSize: 12.spMin, color: AppColor.grayColor),
                        ),
                      ],
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
                    ).wrapPaddingLeft(15),
                  ],
                ).wrapPaddingHorizontal(5),
              ],
            ).wrapPaddingBottom(15);
          },
        ),
      ).wrapPaddingSymmetric(vertical: 17, horizontal: 15),
    );
  }

  Widget buildProductsView(double height) {
    return Column(
      children: [
        4.verticalSpace,
        Expanded(
          child: GridView.builder(
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
          ).wrapPaddingHorizontal(15),
        ),
      ],
    );
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }
}
