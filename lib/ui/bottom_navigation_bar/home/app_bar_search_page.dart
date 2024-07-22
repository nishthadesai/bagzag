import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../widget/app_text_filed.dart';
import '../../../widget/base_app_bar.dart';

@RoutePage()
class AppBarSearchPage extends StatefulWidget {
  const AppBarSearchPage({super.key});

  @override
  State<AppBarSearchPage> createState() => _AppBarSearchPageState();
}

class _AppBarSearchPageState extends State<AppBarSearchPage> {
  List searchList = ["T-Shirt", "Shirt Man", "T-shirts Women", "T-shirts Boys"];
  TextEditingController searchController = TextEditingController();
  ValueNotifier<String> searchText = ValueNotifier("");

  List recentSearch = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        child: buildAppBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: buildView(),
    );
  }

  Widget buildAppBar() {
    return BaseAppBar(
      showTitle: true,
      backgroundColor: AppColor.white,
      titleWidget: AppTextField(
        controller: searchController,
        hintStyle:
            textRegular.copyWith(color: AppColor.black, fontSize: 16.spMin),
        label: '',
        hint: S.of(context).search,
        borderRadius: BorderRadius.circular(5).r,
        contentPadding: EdgeInsets.zero,
        keyboardType: TextInputType.name,
        keyboardAction: TextInputAction.search,
        textCapitalization: TextCapitalization.none,
        prefixIcon: Image.asset(
          Assets.imageSearch,
          height: 20.r,
          width: 20.r,
        ).wrapPaddingOnly(left: 11, top: 13, bottom: 13, right: 12),
        onChanged: (val) {
          searchText.value = val ?? '';
        },
        onSubmit: (value) {
          if (recentSearch.contains(value)) {
            searchController.text = "";
            searchText.value = "";
          } else {
            recentSearch.add(value);
          }
        },
        suffixIcon: GestureDetector(
          onTap: () {
            searchController.text = "";
            searchText.value = "";
          },
          child: Icon(
            Icons.close,
            color: AppColor.black,
            size: 22.r,
          ).wrapPaddingOnly(right: 16, bottom: 13, top: 13),
        ),
      ),
    );
  }

  Widget buildView() {
    return ValueListenableBuilder(
      valueListenable: searchText,
      builder: (context, value, child) {
        return value != ""
            ? searchList.contains(value)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      searchList.length,
                      (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            18.verticalSpace,
                            GestureDetector(
                              onTap: () {
                                recentSearch.add(searchList[index]);
                                appRouter.replace(SearchedProductViewRoute(
                                    productName: searchList[index]));
                              },
                              child: Text(
                                searchList[index],
                              ),
                            ),
                          ],
                        ).wrapPaddingSymmetric(horizontal: 28);
                      },
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.imageNoProducts,
                        ),
                        10.verticalSpace,
                        Text(
                          S.of(context).noProductsFound,
                          style: textMedium.copyWith(
                              fontSize: 20.spMin, color: AppColor.black),
                        ),
                      ],
                    ).wrapPaddingHorizontal(20),
                  )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  18.verticalSpace,
                  Text(
                    S.of(context).recentSearches,
                    style: textMedium.copyWith(
                        fontSize: 14.spMin, color: AppColor.black),
                  ),
                  7.verticalSpace,
                  Wrap(
                    children: List.generate(
                      recentSearch.length,
                      (index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4).r,
                              color: AppColor.white,
                              border: Border.all(color: AppColor.grayColor)),
                          child: Text(
                            recentSearch[index],
                            style: textRegular.copyWith(
                                fontSize: 16.spMin, color: AppColor.grayColor),
                          ).wrapPaddingSymmetric(vertical: 9, horizontal: 24),
                        ).wrapPaddingOnly(right: 10, bottom: 10);
                      },
                    ),
                  ),
                ],
              ).wrapPaddingHorizontal(15);
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
