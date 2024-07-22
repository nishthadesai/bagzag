import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../router/app_router.dart';
import '../../../../widget/base_app_bar.dart';

@RoutePage()
class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
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
        "About Us",
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
          Image.asset(
            Assets.imageAboutUs,
            height: 131.r,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          16.verticalSpace,
          Text(
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English \n\n"
                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English \n\n"
                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English "
                .toTitleCase(),
            softWrap: true,
            overflow: TextOverflow.visible,
            style: textRegular.copyWith(
                fontSize: 14.spMin, color: AppColor.grayColor),
          ).wrapPaddingHorizontal(16),
          33.verticalSpace,
        ],
      ),
    );
  }
}
