import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/values/colors.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_demo_structure/widget/show_message.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/my_data/setting_data.dart';
import '../../../../generated/l10n.dart';
import '../../../../values/style.dart';
import '../../../../widget/base_app_bar.dart';

@RoutePage()
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final Map<int, PageRouteInfo> routePage = {
    1: SharedSettingRoute(),
    4: ChangePasswordRoute(),
    8: TermsRoute(),
    9: PolicyRoute(),
    10: AboutUsRoute(),
    11: ContactUsRoute(),
  };
  ValueNotifier<bool> isOn = ValueNotifier(false);
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
      centerTitle: false,
      backgroundColor: AppColor.white,
      titleWidget: Text(
        S.of(context).settings,
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
        children: List.generate(
          settingDataList.length,
          (index) {
            SettingData data = settingDataList[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                GestureDetector(
                  onTap: () {
                    if (routePage[index] != null) {
                      appRouter.push(routePage[index]!);
                    } else {
                      return null;
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.setting,
                        style: textMedium.copyWith(
                            fontSize: 15.spMin, color: AppColor.black),
                      ),
                      index != 0
                          ? Icon(
                              Icons.arrow_forward_ios,
                              size: 11.r,
                              color: AppColor.grayColor,
                            )
                          : ValueListenableBuilder(
                              valueListenable: isOn,
                              builder: (context, value, child) {
                                return SizedBox(
                                  height: 22.r,
                                  width: 48.w,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: CupertinoSwitch(
                                      applyTheme: true,
                                      activeColor: AppColor.pinkColor,
                                      value: value,
                                      onChanged: (value) {
                                        isOn.value = !isOn.value;
                                        if (isOn.value) {
                                          showMessage(
                                              S.of(context).notificationOn);
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
                5.verticalSpace,
                Divider(),
              ],
            );
          },
        ),
      ).wrapPaddingOnly(left: 17, top: 11, right: 17),
    );
  }

  @override
  void dispose() {
    isOn.dispose();
    super.dispose();
  }
}
