import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
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

class _WalkThroughThreePageState extends State<WalkThroughThreePage>
    with TickerProviderStateMixin {
  late AnimationController _firstImageAnimationController;
  late AnimationController _secondImageAnimationController;

  @override
  void initState() {
    _firstImageAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    Timer(
      Duration(milliseconds: 200),
      () => _firstImageAnimationController.forward(),
    );
    _secondImageAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    Timer(
      Duration(milliseconds: 200),
      () => _secondImageAnimationController.forward(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _firstImageAnimationController.dispose();
    _secondImageAnimationController.dispose();
    super.dispose();
  }

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
            SlideTransition(
              position: Tween<Offset>(begin: Offset(-1, -1), end: Offset.zero)
                  .animate(_secondImageAnimationController),
              child: FadeTransition(
                opacity: _secondImageAnimationController,
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 34).r,
                  child: Image.asset(
                    Assets.imageWalk31,
                    width: 230.w,
                    height: 229.r,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SlideTransition(
              position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
                  .animate(_firstImageAnimationController),
              child: FadeTransition(
                opacity: _firstImageAnimationController,
                child: Container(
                  margin: EdgeInsets.only(top: 245, left: 179).r,
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    Assets.imageWalk32,
                    height: 173.r,
                    width: 176.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
        height < 600 ? 21.verticalSpace : 26.verticalSpace,
        AnimatedTextKit(
          repeatForever: true,
          isRepeatingAnimation: false,
          animatedTexts: [
            TyperAnimatedText(
              S.of(context).trackOrder,
              textStyle: textBold.copyWith(
                  fontFamily: "Playfair",
                  color: AppColor.pinkColor,
                  fontSize: 18.spMin),
              speed: Duration(milliseconds: 100),
            ),
          ],
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
