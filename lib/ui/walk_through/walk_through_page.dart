import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_structure/core/db/app_db.dart';
import 'package:flutter_demo_structure/ui/auth/store/auth_store.dart';
import 'package:flutter_demo_structure/ui/walk_through/walk_through_page_one.dart';
import 'package:flutter_demo_structure/ui/walk_through/walk_through_page_three.dart';
import 'package:flutter_demo_structure/ui/walk_through/walk_through_page_two.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_demo_structure/widget/app_text_filed.dart';
import 'package:flutter_demo_structure/widget/show_message.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../router/app_router.dart';
import '../../widget/button_widget.dart';

@RoutePage()
class WalkThroughPage extends StatefulWidget {
  const WalkThroughPage({super.key});

  @override
  State<WalkThroughPage> createState() => _WalkThroughPageState();
}

class _WalkThroughPageState extends State<WalkThroughPage> {
  PageController pageController = PageController();
  ValueNotifier<int> currentPage = ValueNotifier(0);
  ValueNotifier<bool> isTapped = ValueNotifier(true);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final phoneRegex = RegExp(r'^\d{10}$');
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: buildView(height),
    );
  }

  Widget buildView(double height) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: SizedBox(
              height: height < 600 ? 600.r : 570.r,
              child: PageView(
                onPageChanged: (index) {
                  currentPage.value = index;
                },
                controller: pageController,
                children: [
                  WalkThroughOnePage(),
                  WalkThroughTwoPage(),
                  WalkThroughThreePage(),
                ],
              ),
            ),
          ),
          buildIndicator(),
          37.verticalSpace,
          buildSignupSignInButton(),
          27.verticalSpace,
          Center(
            child: GestureDetector(
              onTap: () {
                appRouter.replaceAll([BottomNavigationBarRoute()]);
              },
              child: Text(
                S.of(context).continueAsAGuest,
                style: textRegular.copyWith(
                    decoration: TextDecoration.underline,
                    fontSize: 18.spMin,
                    color: AppColor.grayColor),
              ),
            ),
          ),
          26.verticalSpace,
        ],
      ),
    );
  }

  Widget buildSignupSignInButton() {
    return Row(
      children: [
        AppButton(
          height: 55.r,
          width: 163.w,
          radius: 5.r,
          elevation: 0,
          Text(
            S.of(context).signUp,
            style:
                textMedium.copyWith(fontSize: 18.spMin, color: AppColor.black),
          ),
          () {
            appRouter.push(CreateAccountRoute());
          },
        ),
        19.horizontalSpace,
        AppButton(
          bgColor: AppColor.black,
          radius: 5.r,
          elevation: 0,
          height: 55.r,
          width: 163.w,
          Text(
            S.of(context).signIn,
            style:
                textMedium.copyWith(fontSize: 18.spMin, color: AppColor.white),
          ),
          () {
            buildSignInBottomSheet();
          },
        ),
      ],
    ).wrapPaddingSymmetric(horizontal: 15);
  }

  Widget buildIndicator() {
    return SmoothPageIndicator(
      controller: pageController,
      count: 3,
      effect: ExpandingDotsEffect(
        radius: 0,
        dotWidth: 50,
        expansionFactor: 1.2,
        dotHeight: 5.r,
        dotColor: AppColor.grayColor.withOpacity(0.20),
        activeDotColor: AppColor.pinkColor,
      ),
    ).wrapPaddingSymmetric(horizontal: 15);
  }

  Future buildSignInBottomSheet() {
    return showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      backgroundColor: AppColor.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14).r, topRight: Radius.circular(14).r),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14).r,
                  topRight: Radius.circular(14).r),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    10.verticalSpace,
                    Center(
                      child: Container(
                        height: 4.r,
                        width: 32.r,
                        decoration: BoxDecoration(
                          color: AppColor.black,
                          borderRadius: BorderRadius.circular(3).r,
                        ),
                      ),
                    ),
                    30.verticalSpace,
                    Image.asset(
                      Assets.imageLogo,
                      height: 56.r,
                      width: 54.r,
                    ),
                    17.verticalSpace,
                    Text(
                      S.of(context).welcomeBack,
                      style: textMedium.copyWith(fontSize: 18.spMin),
                    ),
                    5.verticalSpace,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: S.of(context).signInTo,
                            style: textLight.copyWith(
                                fontSize: 24.spMin, color: AppColor.black),
                          ),
                          TextSpan(
                            text: " Bagzag",
                            style: textLight.copyWith(
                                fontSize: 24.spMin, color: AppColor.pinkColor),
                          ),
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    Row(
                      children: [
                        Image.asset(
                          Assets.imageFbLogin,
                          height: 50.r,
                          width: 50.w,
                        ),
                        14.horizontalSpace,
                        GestureDetector(
                          onTap: () {
                            authStore.googleSignIn;
                          },
                          child: Image.asset(
                            Assets.imageGoogleLogin,
                            height: 50.r,
                            width: 50.w,
                          ),
                        ),
                        14.horizontalSpace,
                        Image.asset(
                          Assets.imageAppleLogin,
                          height: 50.r,
                          width: 50.w,
                        ),
                      ],
                    ).wrapPaddingHorizontal(83),
                    26.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.imageRightArrow,
                          width: 22.w,
                        ),
                        4.horizontalSpace,
                        Text(S.of(context).or,
                            style: textMedium.copyWith(
                                fontSize: 16.spMin, color: AppColor.grayColor)),
                        4.horizontalSpace,
                        Image.asset(
                          Assets.imageLeftArrow,
                          width: 22.w,
                        ),
                      ],
                    ).wrapPaddingSymmetric(horizontal: 129),
                    20.verticalSpace,
                    AppTextField(
                      controller: emailController,
                      validators: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).pleaseEnterEmailPhoneNumber;
                        } else if (emailRegex.hasMatch(value)) {
                          return null; // Valid email
                        } else if (phoneRegex.hasMatch(value)) {
                          return null; // Valid phone number
                        } else {
                          return S.of(context).enterAValidEmailOrPhoneNumber;
                        }
                      },
                      borderRadius: BorderRadius.circular(5).r,
                      textCapitalization: TextCapitalization.none,
                      keyboardAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      height: 55.r,
                      label: '',
                      hint: S.of(context).emailPhoneNumber,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 23, vertical: 20).r,
                    ),
                    10.verticalSpace,
                    ValueListenableBuilder(
                      valueListenable: isTapped,
                      builder: (context, value, child) {
                        return AppTextField(
                          obscureText: value == true ? true : false,
                          controller: passwordController,
                          validators: passwordValidator,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              isTapped.value = !isTapped.value;
                            },
                            child: Image.asset(
                              value == true
                                  ? Assets.imagePasswordEye
                                  : Assets.imagePasswordVisible,
                              height: 14.r,
                              width: 21.w,
                            ).wrapPaddingSymmetric(
                                vertical: 20, horizontal: 17),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          keyboardAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.none,
                          borderRadius: BorderRadius.circular(5).r,
                          height: 55.r,
                          label: '',
                          hint: S.of(context).password,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 23, vertical: 0)
                                  .r,
                        );
                      },
                    ),
                    21.verticalSpace,
                    AppButton(
                      radius: 5.r,
                      Text(
                        S.of(context).signIn,
                        style: textMedium.copyWith(
                            fontSize: 18.spMin, color: AppColor.white),
                      ),
                      () {
                        if (formKey.currentState!.validate()) {
                          showMessage(S.of(context).loggedinSuccesfully);
                          appDB.isLogin = true;
                          appRouter.replaceAll([BottomNavigationBarRoute()]);
                        }
                      },
                      bgColor: AppColor.black,
                      height: 55.r,
                      width: double.infinity,
                    ),
                    27.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        appRouter.push(ForgotPasswordRoute());
                      },
                      child: Text(
                        S.of(context).forgotPassword,
                        style: textRegular.copyWith(
                            decoration: TextDecoration.underline,
                            fontSize: 18.spMin,
                            color: AppColor.grayColor),
                      ),
                    ),
                    31.verticalSpace,
                  ],
                ).wrapPaddingHorizontal(15),
              ),
            ),
          ),
        );
      },
    ).whenComplete(
      () {
        FocusScope.of(context).unfocus();
        emailController.clear();
        passwordController.clear();
      },
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    currentPage.dispose();
    isTapped.dispose();
    super.dispose();
  }
}
