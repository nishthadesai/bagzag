import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_demo_structure/widget/show_message.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../values/colors.dart';
import '../../../values/style.dart';
import '../../../values/validator.dart';
import '../../../widget/app_text_filed.dart';
import '../../../widget/base_app_bar.dart';
import '../../../widget/button_widget.dart';

@RoutePage()
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  ValueNotifier<bool> isTapped = ValueNotifier(true);
  ValueNotifier<bool> isConfirmTapped = ValueNotifier(true);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: AppColor.white,
      // extendBody: true,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        child: buildAppBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: buildView(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            bottom: bottom > 0 ? bottom + 35 : 35, left: 15, right: 15),
        child: AppButton(
          radius: 5.r,
          Text(
            S.of(context).update,
            style:
                textMedium.copyWith(fontSize: 18.spMin, color: AppColor.white),
          ),
          () {
            if (formKey.currentState!.validate()) {
              appRouter.replaceAll([WalkThroughRoute()]);
              showMessage(S.of(context).passwordUpdatedSuccesfully);
            }
          },
          bgColor: AppColor.black,
          height: 55.r,
          width: double.infinity,
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
            Center(
              child: Text(
                S.of(context).enterNewPasswordBelow,
                style: textRegular.copyWith(
                    fontSize: 14.spMin, color: AppColor.grayColor),
              ),
            ),
            16.verticalSpace,
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
                  hint: S.of(context).password,
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
                        passwordController.text) {
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
          ],
        ).wrapPaddingHorizontal(15),
      ),
    );
  }

  Widget buildAppBar() {
    return BaseAppBar(
      leadingIcon: true,
      leadingWidget: GestureDetector(
        onTap: () {
          appRouter.maybePop();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 17.r,
        ),
      ),
      titleWidget: Text(
        S.of(context).resetPassword,
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
      showTitle: true,
      centerTitle: true,
      backgroundColor: AppColor.white,
    );
  }

  @override
  void dispose() {
    isConfirmTapped.dispose();
    isTapped.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
    super.dispose();
  }
}
