import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/data/my_data/messages_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../router/app_router.dart';
import '../../../../values/colors.dart';
import '../../../../values/style.dart';
import '../../../../widget/base_app_bar.dart';

@RoutePage()
class MessageChattingPage extends StatefulWidget {
  final MessagesData messagesData;
  const MessageChattingPage({super.key, required this.messagesData});

  @override
  State<MessageChattingPage> createState() => _MessageChattingPageState();
}

class _MessageChattingPageState extends State<MessageChattingPage> {
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
      titleWidget: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              appRouter.maybePop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 17.r,
              color: Colors.black,
            ),
          ),
          10.horizontalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(3).r,
            child: Image.asset(
              widget.messagesData.dp,
              height: 22.r,
              width: 22.w,
            ),
          ),
          10.horizontalSpace,
          Text(
            widget.messagesData.name,
            style:
                textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
          ),
        ],
      ),
      showTitle: true,
      centerTitle: false,
      backgroundColor: AppColor.white,
    );
  }

  Widget buildView() {
    return Column(
      children: [
        15.verticalSpace,
        Column(
          children: [],
        ),
      ],
    );
  }
}
