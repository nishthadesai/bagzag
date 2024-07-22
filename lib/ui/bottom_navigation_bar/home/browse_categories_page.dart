import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/data/my_data/browse_categories_data.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/l10n.dart';
import '../../../router/app_router.dart';
import '../../../widget/base_app_bar.dart';

@RoutePage()
class BrowseCategoriesPage extends StatefulWidget {
  const BrowseCategoriesPage({super.key});

  @override
  State<BrowseCategoriesPage> createState() => _BrowseCategoriesPageState();
}

class _BrowseCategoriesPageState extends State<BrowseCategoriesPage> {
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
          appRouter.maybePop();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 17.r,
        ),
      ),
      action: [
        Image.asset(
          Assets.imageFilter,
          height: 19.r,
          width: 19.w,
        ),
        Image.asset(
          Assets.imageSearch,
          height: 20.r,
          width: 20.r,
        ).wrapPaddingOnly(left: 11, right: 18),
      ],
      titleWidget: Text(
        S.of(context).browseCategories,
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
      showTitle: true,
      centerTitle: true,
      backgroundColor: AppColor.white,
    );
  }

  Widget buildView(double height) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: browseCategoriesList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: height < 600 ? 175.r : 166.r,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15),
            itemBuilder: (context, index) {
              BrowseCategoriesData categoryData = browseCategoriesList[index];
              return GestureDetector(
                onTap: () {
                  appRouter.push(CategoriesDetailsRoute(
                      categoryName: categoryData.categoryName,
                      image: categoryData.image,
                      index: index));
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.grayColor.withOpacity(0.20),
                      ),
                      borderRadius: BorderRadius.circular(5).r),
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          categoryData.image,
                          height: 105.r,
                          width: double.infinity,
                        ).wrapPaddingOnly(top: 10, right: 10, left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5).r,
                            color: AppColor.grayColor.withOpacity(0.15)),
                      ).wrapPaddingAll(5),
                      6.verticalSpace,
                      Text(
                        categoryData.categoryName,
                        style: textMedium.copyWith(
                            fontSize: 15.spMin, color: AppColor.black),
                      ),
                      10.verticalSpace,
                    ],
                  ),
                ),
              );
            },
          ).wrapPaddingOnly(top: 8, left: 15, right: 15, bottom: 32),
        )
      ],
    );
  }
}
