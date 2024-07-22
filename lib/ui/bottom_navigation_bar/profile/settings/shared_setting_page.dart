import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_demo_structure/widget/button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/my_data/share_setting_data.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../../values/colors.dart';
import '../../../../values/style.dart';
import '../../../../widget/base_app_bar.dart';

@RoutePage()
class SharedSettingPage extends StatefulWidget {
  const SharedSettingPage({super.key});

  @override
  State<SharedSettingPage> createState() => _SharedSettingPageState();
}

class _SharedSettingPageState extends State<SharedSettingPage> {
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
      centerTitle: true,
      backgroundColor: AppColor.white,
      titleWidget: Text(
        "Sharing Settings",
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
      leadingIcon: true,
      leadingWidget: GestureDetector(
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
  }

  Widget buildView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          5.verticalSpace,
          Container(
            padding: EdgeInsets.only(top: 10, left: 15).r,
            height: 45.r,
            width: double.infinity,
            color: AppColor.grayColor.withOpacity(0.12),
            child: Text(
              "Set all social media",
              style: textRegular.copyWith(
                  fontSize: 16.spMin, color: AppColor.black),
            ),
          ),
          15.verticalSpace,
          Column(
            children: List.generate(
              sharingSettingList.length,
              (index) {
                SharingSettingsData data = sharingSettingList[index];
                return Container(
                  height: 55.r,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5).r,
                      border: Border.all(
                          color: AppColor.grayColor.withOpacity(0.50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            data.image,
                            height: 24.r,
                            width: 24.w,
                          ),
                          12.horizontalSpace,
                          Text(
                            data.name,
                            style: textRegular.copyWith(
                                fontSize: 16.spMin, color: AppColor.black),
                          )
                        ],
                      ).wrapPaddingLeft(11),
                      ValueListenableBuilder(
                        valueListenable: data.isConnect,
                        builder: (context, value, child) {
                          return AppButton(
                            value
                                ? Row(
                                    children: [
                                      Image.asset(
                                        Assets.imageTick,
                                        height: 8.r,
                                        width: 11.w,
                                      ),
                                      7.horizontalSpace,
                                      Text(
                                        S.of(context).connected,
                                        style: textMedium.copyWith(
                                            fontSize: 12.spMin,
                                            color: AppColor.pinkColor),
                                      ),
                                    ],
                                  )
                                : Text(
                                    S.of(context).connect,
                                    style: textMedium.copyWith(
                                        fontSize: 12.spMin,
                                        color: AppColor.white),
                                  ),
                            height: 30.r,
                            () {
                              if (data.isConnect.value) {
                                buildBottomSheet(data);
                              } else {
                                data.isConnect.value = !data.isConnect.value;
                              }
                            },
                            borderColor: AppColor.transparent,
                            bgColor: value
                                ? AppColor.pinkColor.withOpacity(0.13)
                                : AppColor.black,
                          ).wrapPaddingOnly(top: 12, bottom: 12, right: 15);
                        },
                      ),
                    ],
                  ),
                ).wrapPaddingBottom(10);
              },
            ),
          ).wrapPaddingHorizontal(15),
        ],
      ),
    );
  }

  Future buildBottomSheet(SharingSettingsData data) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14).r),
      ),
      backgroundColor: AppColor.white,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            10.verticalSpace,
            Container(
              height: 4.r,
              width: 32.w,
              decoration: BoxDecoration(
                color: AppColor.black,
                borderRadius: BorderRadius.circular(3).r,
              ),
            ),
            32.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  data.image,
                  height: 24.r,
                  width: 24.r,
                ),
                10.horizontalSpace,
                Text(
                  data.name,
                  style: textRegular.copyWith(
                      fontSize: 20.spMin, color: AppColor.black),
                ),
              ],
            ),
            10.verticalSpace,
            Text(
              "Do you want to unlink\n from BagZag sharing settings?",
              style: textMedium.copyWith(
                  fontSize: 18.spMin, color: AppColor.black),
              maxLines: 2,
              softWrap: false,
              textAlign: TextAlign.center,
            ),
            32.verticalSpace,
            AppButton(
              bgColor: AppColor.black,
              height: 55.r,
              width: double.infinity,
              Text(
                "Unlink",
                style: textMedium.copyWith(
                    fontSize: 18.spMin, color: AppColor.white),
              ),
              () {
                data.isConnect.value = !data.isConnect.value;
                appRouter.maybePop();
              },
            ),
            5.verticalSpace,
          ],
        ).wrapPaddingHorizontal(15);
      },
    );
  }
}
