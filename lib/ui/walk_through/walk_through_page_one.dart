import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../values/colors.dart';
import '../../values/style.dart';

class WalkThroughOnePage extends StatefulWidget {
  const WalkThroughOnePage({super.key});

  @override
  State<WalkThroughOnePage> createState() => _WalkThroughOnePageState();
}

class _WalkThroughOnePageState extends State<WalkThroughOnePage> {
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
            Image.asset(
              Assets.imageWalk11,
              height: 257.h,
              width: 257.w,
              fit: BoxFit.fill,
            ),
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 176, left: 165).r,
              child: Image.asset(
                height: 177.r,
                width: 178.w,
                fit: BoxFit.fill,
                Assets.imageWalk12,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 271).r,
              alignment: Alignment.topLeft,
              child: Image.asset(
                fit: BoxFit.fill,
                Assets.imageWalk13,
                height: 143.r,
                width: 144.w,
              ),
            )
          ],
        ),
        height < 600 ? 25.verticalSpace : 30.verticalSpace,
        Text(
          S.of(context).trendyCollection,
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
                text: S.of(context).letsCreateYourOwn,
                style: textLight.copyWith(
                    height: height < 600 ? 1 : 1.2,
                    fontSize: 34.spMin,
                    color: AppColor.black),
              ),
              TextSpan(
                text: " style",
                style: textLight.copyWith(
                    height: height < 600 ? 1 : 1.2,
                    fontSize: 34.spMin,
                    color: AppColor.pinkColor),
              )
            ],
          ),
        ).wrapPaddingRight(100),
      ],
    ).wrapPaddingSymmetric(horizontal: 15);
  }
}
