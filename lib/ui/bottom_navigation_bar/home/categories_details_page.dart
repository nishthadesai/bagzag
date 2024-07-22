import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/my_data/category_details_data.dart';

@RoutePage()
class CategoriesDetailsPage extends StatefulWidget {
  final String image;
  final int index;
  final String categoryName;
  const CategoriesDetailsPage(
      {super.key,
      required this.image,
      required this.categoryName,
      required this.index});

  @override
  State<CategoriesDetailsPage> createState() => _CategoriesDetailsPageState();
}

class _CategoriesDetailsPageState extends State<CategoriesDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverLayoutBuilder(
              builder: (context, constraints) {
                return SliverAppBar(
                  backgroundColor: AppColor.white,
                  title: Text(""),
                  expandedHeight: 150,
                  stretch: true,
                  pinned: true,
                  snap: false,
                  floating: true,
                  scrolledUnderElevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      height: 178,
                      // width: double.infinity,
                      color: AppColor.grayColor.withOpacity(0.15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.categoryName,
                            style: textSemiBold.copyWith(
                                fontSize: 30.spMin, color: AppColor.black),
                          ).wrapPaddingBottom(21),
                          Container(
                            height: 120.r,
                            width: 122.w,
                            child: Image.asset(
                              widget.image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ).wrapPaddingHorizontal(15),
                    ).wrapPaddingTop(20),
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      appRouter.maybePop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 17.r,
                      color: AppColor.black,
                    ),
                  ),
                );
              },
            )
          ];
        },
        body: buildView(),
      ),
    );
  }

  Widget buildView() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          categoryDetails[widget.index].length,
          (index) {
            if (categoryDetails.keys.contains(widget.index)) {
              CategoryDetailsData data = categoryDetails[widget.index][index];
              return Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.CategoryDetail,
                          style: textMedium.copyWith(
                              fontSize: 16.spMin, color: AppColor.black),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 16.r,
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  Divider(),
                ],
              ).wrapPaddingBottom(18);
            } else {
              return Center(child: Text("No"));
            }
          },
        ),
      ).wrapPaddingSymmetric(vertical: 18, horizontal: 15),
    );
  }
}
