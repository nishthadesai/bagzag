import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/core/db/app_db.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/values/colors.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/my_data/account_list_data.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../values/style.dart';
import '../../../widget/base_app_bar.dart';
import '../../../widget/button_widget.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Map<int, PageRouteInfo> routePage = {
    2: BagzagMallRoute(),
    6: MessagesRoute(),
    10: SettingRoute(),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grayColor.withOpacity(0.20),
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
        S.of(context).account,
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
      action: [
        Image.asset(
          Assets.imageWallet,
          height: 18.r,
          width: 20.r,
        ).wrapPaddingRight(6),
        Center(
          child: Text(
            "\$ 500.00",
            style:
                textMedium.copyWith(fontSize: 14.spMin, color: AppColor.black),
          ).wrapPaddingOnly(right: 25),
        ),
      ],
    );
  }

  Widget buildView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: AppColor.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    11.verticalSpace,
                    Image.asset(
                      Assets.imageStudioPost1ProfilePic,
                      height: 80.r,
                      width: 80.w,
                    ),
                    17.horizontalSpace,
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).davidMarco,
                                style: textSemiBold.copyWith(
                                    fontSize: 20.spMin, color: AppColor.black),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3).r,
                                    border: Border.all(
                                        color: AppColor.grayColor
                                            .withOpacity(0.50))),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      Assets.imageEdit,
                                      height: 10.r,
                                      width: 10.w,
                                    ),
                                    8.horizontalSpace,
                                    Text(S.of(context).edit),
                                  ],
                                ).wrapPaddingSymmetric(
                                    vertical: 6, horizontal: 5),
                              )
                            ],
                          ),
                          12.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "20",
                                    style: textMedium.copyWith(
                                        fontSize: 18.spMin,
                                        color: AppColor.black),
                                  ),
                                  Text(
                                    S.of(context).followers,
                                    style: textRegular.copyWith(
                                        fontSize: 14.spMin,
                                        color: AppColor.grayColor),
                                  )
                                ],
                              ),
                              12.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "20",
                                    style: textMedium.copyWith(
                                        fontSize: 18.spMin,
                                        color: AppColor.black),
                                  ),
                                  Text(
                                    S.of(context).following,
                                    style: textRegular.copyWith(
                                        fontSize: 14.spMin,
                                        color: AppColor.grayColor),
                                  )
                                ],
                              ),
                              23.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "20",
                                    style: textMedium.copyWith(
                                        fontSize: 18.spMin,
                                        color: AppColor.black),
                                  ),
                                  Text(
                                    S.of(context).shares,
                                    style: textRegular.copyWith(
                                        fontSize: 14.spMin,
                                        color: AppColor.grayColor),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                22.verticalSpace,
              ],
            ).wrapPaddingHorizontal(15),
          ),
          5.verticalSpace,
          Container(
            color: AppColor.white,
            child: Column(
              children: [
                Column(
                  children: List.generate(
                    accountDataList.length,
                    (index) {
                      AccountListData data = accountDataList[index];
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.router.push(routePage[index]!);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.dataName,
                                      style: textMedium.copyWith(
                                          fontSize: 16.spMin,
                                          color: AppColor.black),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      data.dataDesc,
                                      style: textRegular.copyWith(
                                          fontSize: 14.spMin,
                                          color: AppColor.grayColor),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 11.r,
                                  color: AppColor.grayColor,
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColor.grayColor.withOpacity(0.30),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                20.verticalSpace,
                AppButton(
                  radius: 5.r,
                  Text(
                    S.of(context).logout,
                    style: textMedium.copyWith(
                        fontSize: 18.spMin, color: AppColor.white),
                  ),
                  () {
                    appDB.logout();
                    appRouter.replaceAll([WalkThroughRoute()]);
                  },
                  bgColor: AppColor.black,
                  height: 55.r,
                  width: double.infinity,
                ),
                60.verticalSpace,
              ],
            ).wrapPaddingOnly(left: 15, top: 15, right: 15),
          ),
        ],
      ),
    );
  }
}
