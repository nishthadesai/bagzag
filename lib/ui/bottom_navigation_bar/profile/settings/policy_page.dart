import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../router/app_router.dart';
import '../../../../widget/base_app_bar.dart';

@RoutePage()
class PolicyPage extends StatefulWidget {
  const PolicyPage({super.key});

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
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
        "Privacy Policy",
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
          16.verticalSpace,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text:
                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English \n\n"
                            .toTitleCase(),
                    style: textRegular.copyWith(
                        fontSize: 14.spMin, color: AppColor.black)),
                TextSpan(
                  text: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English \n\n"
                          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English \n\n"
                          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English "
                      .toTitleCase(),
                  style: textRegular.copyWith(
                      fontSize: 14.spMin, color: AppColor.grayColor),
                )
              ],
            ),
          ),
        ],
      ).wrapPaddingHorizontal(16),
    );
  }
}
