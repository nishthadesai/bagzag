import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../values/colors.dart';
import '../../values/style.dart';

class WalkThroughThreePage extends StatefulWidget {
  const WalkThroughThreePage({super.key});

  @override
  State<WalkThroughThreePage> createState() => _WalkThroughThreePageState();
}

class _WalkThroughThreePageState extends State<WalkThroughThreePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 34).r,
              child: Image.asset(
                Assets.imageWalk31,
                width: 230.w,
                height: 229.r,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 245, left: 179).r,
              alignment: Alignment.centerRight,
              child: Image.asset(
                Assets.imageWalk32,
                height: 173.r,
                width: 176.w,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        height < 600 ? 21.verticalSpace : 26.verticalSpace,
        Text(
          S.of(context).trackOrder,
          style: textBold.copyWith(
              fontFamily: "Playfair",
              color: AppColor.pinkColor,
              fontSize: 18.spMin),
        ),
        10.verticalSpace,
        RichText(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: S.of(context).experienceTheRealtime,
                style: textLight.copyWith(
                    height: height < 600 ? 1 : 1.2,
                    fontSize: 34.spMin,
                    color: AppColor.black),
              ),
              TextSpan(
                text: " Tracking",
                style: textLight.copyWith(
                    height: height < 600 ? 1 : 1.2,
                    fontSize: 34.spMin,
                    color: AppColor.pinkColor),
              )
            ],
          ),
        ).wrapPaddingRight(55),
      ],
    ).wrapPaddingOnly(left: 15, right: 20);
  }
}
