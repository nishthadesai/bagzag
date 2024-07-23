import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/my_data/messages_data.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../../values/colors.dart';
import '../../../../values/style.dart';
import '../../../../widget/base_app_bar.dart';

@RoutePage()
class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
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
      leadingIcon: true,
      leadingWidget: GestureDetector(
        onTap: () {
          appRouter.maybePop();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 17.r,
          color: Colors.black,
        ),
      ),
      titleWidget: Text(
        S.of(context).messages,
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
      showTitle: true,
      centerTitle: true,
      backgroundColor: AppColor.white,
    );
  }

  Widget buildView() {
    return Column(
      children: List.generate(
        messageDataList.length,
        (index) {
          MessagesData messagesData = messageDataList[index];
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  appRouter
                      .push(MessageChattingRoute(messagesData: messagesData));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      child: Image.asset(
                        messagesData.dp,
                        height: 46.r,
                        width: 46.w,
                      ),
                      borderRadius: BorderRadius.circular(3).r,
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                messagesData.name,
                                style: textMedium.copyWith(
                                    fontSize: 16.spMin, color: AppColor.black),
                              ),
                              Text(
                                messagesData.time,
                                style: textRegular.copyWith(
                                    fontSize: 14.spMin,
                                    color: AppColor.grayColor),
                              ),
                            ],
                          ),
                          5.verticalSpace,
                          Text(
                            messagesData.msg,
                            style: textRegular.copyWith(
                                fontSize: 14.spMin, color: AppColor.grayColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              5.verticalSpace,
              Divider(),
              3.verticalSpace,
            ],
          ).wrapPaddingTop(7);
        },
      ),
    ).wrapPaddingHorizontal(15);
  }
}
