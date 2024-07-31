import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
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

class _WalkThroughOnePageState extends State<WalkThroughOnePage>
    with TickerProviderStateMixin {
  late AnimationController _firstImageAnimationController;
  late AnimationController _secondImageAnimationController;
  late AnimationController _thirdImageAnimationController;

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
    _thirdImageAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    Timer(
      Duration(milliseconds: 200),
      () => _thirdImageAnimationController.forward(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _firstImageAnimationController.dispose();
    _secondImageAnimationController.dispose();
    _thirdImageAnimationController.dispose();
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
                  .animate(_thirdImageAnimationController),
              child: FadeTransition(
                opacity: _thirdImageAnimationController,
                child: Image.asset(
                  Assets.imageWalk11,
                  height: 257.h,
                  width: 257.w,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SlideTransition(
              position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
                  .animate(_firstImageAnimationController),
              child: FadeTransition(
                opacity: _firstImageAnimationController,
                child: Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 176, left: 165).r,
                  child: Image.asset(
                    height: 177.r,
                    width: 178.w,
                    fit: BoxFit.fill,
                    Assets.imageWalk12,
                  ),
                ),
              ),
            ),
            SlideTransition(
              position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
                  .animate(_secondImageAnimationController),
              child: FadeTransition(
                  opacity: _secondImageAnimationController,
                  child: Container(
                    margin: EdgeInsets.only(top: 271).r,
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      fit: BoxFit.fill,
                      Assets.imageWalk13,
                      height: 143.r,
                      width: 144.w,
                    ),
                  )),
            ),
          ],
        ),
        height < 600 ? 25.verticalSpace : 30.verticalSpace,
        AnimatedTextKit(
          repeatForever: true,
          isRepeatingAnimation: false,
          animatedTexts: [
            TyperAnimatedText(
              S.of(context).trendyCollection,
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
