import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../../values/colors.dart';
import '../../../../values/style.dart';
import '../../../../values/validator.dart';
import '../../../../widget/app_text_filed.dart';
import '../../../../widget/base_app_bar.dart';
import '../../../../widget/button_widget.dart';
import '../../../../widget/show_message.dart';

@RoutePage()
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  ValueNotifier<bool> isTapped = ValueNotifier(true);
  ValueNotifier<bool> isNewTapped = ValueNotifier(true);
  ValueNotifier<bool> isConfirmTapped = ValueNotifier(true);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
        S.of(context).changePassword,
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
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            23.verticalSpace,
            Image.asset(
              Assets.imageVerification,
              height: 130.r,
              width: 117.w,
            ),
            24.verticalSpace,
            Text(
              S.of(context).youCanChangeThePasswordForSecurityPurpose,
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: textRegular.copyWith(
                  fontSize: 14.spMin, color: AppColor.grayColor),
            ).wrapPaddingHorizontal(40),
            19.verticalSpace,
            ValueListenableBuilder(
              valueListenable: isTapped,
              builder: (context, value, child) {
                return AppTextField(
                  obscureText: value,
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
                    ).wrapPaddingSymmetric(vertical: 20, horizontal: 17),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  keyboardAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  borderRadius: BorderRadius.circular(5).r,
                  height: 55.r,
                  label: '',
                  hint: "Current Password",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 23, vertical: 0).r,
                );
              },
            ),
            10.verticalSpace,
            ValueListenableBuilder(
              valueListenable: isNewTapped,
              builder: (context, value, child) {
                return AppTextField(
                  obscureText: value,
                  controller: newPasswordController,
                  validators: newPasswordValidator,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      isNewTapped.value = !isNewTapped.value;
                    },
                    child: Image.asset(
                      value == true
                          ? Assets.imagePasswordEye
                          : Assets.imagePasswordVisible,
                      height: 14.r,
                      width: 21.w,
                    ).wrapPaddingSymmetric(vertical: 20, horizontal: 17),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  keyboardAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  borderRadius: BorderRadius.circular(5).r,
                  height: 55.r,
                  label: '',
                  hint: "New Password",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 23, vertical: 0).r,
                );
              },
            ),
            10.verticalSpace,
            ValueListenableBuilder(
              valueListenable: isConfirmTapped,
              builder: (context, value, child) {
                return AppTextField(
                  obscureText: value,
                  controller: cPasswordController,
                  validators: (value) {
                    if (value!.isEmpty) {
                      return S.of(context).pleaseEnterConfirmPassword;
                    } else if (cPasswordController.text !=
                        newPasswordController.text) {
                      return S.of(context).passwordConfirmPasswordMustBeSame;
                    }
                    return null;
                  },
                  suffixIcon: GestureDetector(
                    onTap: () {
                      isConfirmTapped.value = !isConfirmTapped.value;
                    },
                    child: Image.asset(
                      value == true
                          ? Assets.imagePasswordEye
                          : Assets.imagePasswordVisible,
                      height: 14.r,
                      width: 21.w,
                    ).wrapPaddingSymmetric(vertical: 20, horizontal: 17),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  keyboardAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.none,
                  borderRadius: BorderRadius.circular(5).r,
                  height: 55.r,
                  label: '',
                  hint: S.of(context).confirmPassword,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 23, vertical: 0).r,
                );
              },
            ),
            15.verticalSpace,
            AppButton(
              bgColor: AppColor.black,
              height: 55.r,
              width: double.infinity,
              radius: 5.r,
              Text(
                S.of(context).update,
                style: textMedium.copyWith(
                    fontSize: 18.spMin, color: AppColor.white),
              ),
              () {
                if (formKey.currentState!.validate()) {
                  appRouter.maybePop();
                  showMessage(S.of(context).passwordChangedSuccessfully);
                }
              },
            ),
          ],
        ).wrapPaddingHorizontal(15),
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    newPasswordController.dispose();
    cPasswordController.dispose();
    isTapped.dispose();
    isConfirmTapped.dispose();
    isNewTapped.dispose();
    super.dispose();
  }
}
