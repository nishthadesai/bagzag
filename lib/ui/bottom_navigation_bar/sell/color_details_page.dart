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
class CreatePostColorDetailsPage extends StatefulWidget {
  const CreatePostColorDetailsPage({super.key});

  @override
  State<CreatePostColorDetailsPage> createState() =>
      _CreatePostColorDetailsPageState();
}

class _CreatePostColorDetailsPageState
    extends State<CreatePostColorDetailsPage> {
  ValueNotifier<int> selectedValue = ValueNotifier(0);
  String selectedColor = "";
  List<String> colorList = [
    "Red",
    "Black",
    "yellow",
    "Pink",
    "Purple",
    "Blue",
    "Brown",
    "White"
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
          S.of(context).submit,
          style: textMedium.copyWith(fontSize: 18.spMin, color: AppColor.white),
        ),
        () {
          appRouter.maybePop(selectedColor);
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
        S.of(context).color,
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
              colorList.length,
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
                              colorList[index],
                              style: textMedium.copyWith(
                                  fontSize: 16.spMin, color: AppColor.black),
                            ),
                            Radio(
                              activeColor: AppColor.pinkColor,
                              value: index,
                              groupValue: value,
                              onChanged: (val) {
                                selectedValue.value = val!;
                                selectedColor = colorList[selectedValue.value];
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
