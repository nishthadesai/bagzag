import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../values/colors.dart';
import '../../values/style.dart';

class WalkThroughTwoPage extends StatefulWidget {
  const WalkThroughTwoPage({super.key});

  @override
  State<WalkThroughTwoPage> createState() => _WalkThroughTwoPageState();
}

class _WalkThroughTwoPageState extends State<WalkThroughTwoPage>
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
              position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
                  .animate(_firstImageAnimationController),
              child: FadeTransition(
                opacity: _firstImageAnimationController,
                child: Container(
                  margin: EdgeInsets.only(top: 33, right: 35).r,
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    Assets.imageWalk22,
                    height: 162.r,
                    width: 127.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SlideTransition(
              position: Tween<Offset>(begin: Offset(1, 1), end: Offset.zero)
                  .animate(_thirdImageAnimationController),
              child: FadeTransition(
                opacity: _thirdImageAnimationController,
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 228).r,
                  child: Image.asset(
                    Assets.imageWalk23,
                    height: 203.r,
                    width: 236.w,
                    fit: BoxFit.fill,
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
                  margin: EdgeInsets.only(top: 82, right: 171).r,
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    Assets.imageWalk21,
                    height: 204.r,
                    width: 164.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
        height < 600 ? 8.verticalSpace : 13.verticalSpace,
        AnimatedTextKit(
          repeatForever: true,
          isRepeatingAnimation: false,
          animatedTexts: [
            TyperAnimatedText(
              S.of(context).payments,
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
                text: S.of(context).Secure,
                style: textLight.copyWith(
                    height: height < 600 ? 1 : 1.2,
                    fontSize: 34.spMin,
                    color: AppColor.black),
              ),
              TextSpan(
                text: " payment",
                style: textLight.copyWith(
                    height: height < 600 ? 1 : 1.2,
                    fontSize: 34.spMin,
                    color: AppColor.pinkColor),
              )
            ],
          ),
        ).wrapPaddingRight(122),
      ],
    ).wrapPaddingSymmetric(horizontal: 15);
  }
}
