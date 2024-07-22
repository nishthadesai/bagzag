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
class CreatePostBrandDetailsPage extends StatefulWidget {
  const CreatePostBrandDetailsPage({super.key});

  @override
  State<CreatePostBrandDetailsPage> createState() =>
      _CreatePostBrandDetailsPageState();
}

class _CreatePostBrandDetailsPageState
    extends State<CreatePostBrandDetailsPage> {
  ValueNotifier<int> selectedValue = ValueNotifier(0);
  String selectedBrand = "";
  List<String> brandList = [
    "Brand 1",
    "Brand 2",
    "Brand 3",
    "Brand 4",
    "Brand 5",
    "Brand 6",
    "Brand 7",
    "Brand 8",
    "Brand 9",
    "Brand 10",
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
          appRouter.maybePop(selectedBrand);
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
        S.of(context).brand,
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
      leadingIcon: true,
      leadingWidget: GestureDetector(
        onTap: () {
          appRouter.maybePop(selectedValue);
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
              brandList.length,
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
                              brandList[index],
                              style: textMedium.copyWith(
                                  fontSize: 16.spMin, color: AppColor.black),
                            ),
                            Radio(
                              activeColor: AppColor.pinkColor,
                              value: index,
                              groupValue: value,
                              onChanged: (val) {
                                selectedValue.value = val!;
                                selectedBrand = brandList[selectedValue.value];
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
