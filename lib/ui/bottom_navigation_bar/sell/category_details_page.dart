import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/l10n.dart';
import '../../../router/app_router.dart';
import '../../../values/colors.dart';
import '../../../values/style.dart';
import '../../../widget/base_app_bar.dart';
import '../../../widget/button_widget.dart';

@RoutePage()
class CreatePostCategoryDetailsPage extends StatefulWidget {
  const CreatePostCategoryDetailsPage({super.key});

  @override
  State<CreatePostCategoryDetailsPage> createState() =>
      _CreatePostCategoryDetailsPageState();
}

class _CreatePostCategoryDetailsPageState
    extends State<CreatePostCategoryDetailsPage> {
  ValueNotifier<int> selectedValue = ValueNotifier(0);
  String selectedCategory = "";
  List<String> categoryList = [
    "Men",
    "Women",
    "Kids",
    "Beauty",
    "Home & Living",
    "Camera & Photo",
    "Coins	&	Paper	Money",
    "Collectibles",
    "Computers/Tablets	&	Networking",
    "Consumer	Electronics"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        child: buildAppBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: buildView(),
      bottomNavigationBar: AppButton(
        bgColor: AppColor.black,
        height: 55.r,
        width: double.infinity,
        radius: 5.r,
        Text(
          "Submit",
          style: textMedium.copyWith(fontSize: 18.spMin, color: AppColor.white),
        ),
        () {
          appRouter.maybePop(selectedCategory);
        },
      ).wrapPaddingAll(15),
    );
  }

  Widget buildAppBar() {
    return BaseAppBar(
      showTitle: true,
      centerTitle: true,
      backgroundColor: AppColor.white,
      titleWidget: Text(
        S.of(context).category,
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
      leadingIcon: true,
      leadingWidget: GestureDetector(
        onTap: () {
          appRouter.maybePop(selectedCategory);
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 17.r,
          color: AppColor.black,
        ),
      ),
    );
  }

  Widget buildView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: List.generate(
              categoryList.length,
              (index) {
                return Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: selectedValue,
                      builder: (context, value, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categoryList[index],
                              style: textMedium.copyWith(
                                  fontSize: 16.spMin, color: AppColor.black),
                            ),
                            Radio(
                              activeColor: AppColor.pinkColor,
                              value: index,
                              groupValue: value,
                              onChanged: (val) {
                                selectedValue.value = val!;
                                selectedCategory =
                                    categoryList[selectedValue.value];
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ).wrapPaddingHorizontal(15),
    );
  }
}
