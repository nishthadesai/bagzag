import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_structure/core/db/app_db.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../router/app_router.dart';
import '../../../widget/base_app_bar.dart';
import '../../../widget/button_widget.dart';

@RoutePage()
class PhoneVerificationPage extends StatefulWidget {
  final bool checked;
  const PhoneVerificationPage({super.key, required this.checked});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  TextEditingController otpController = TextEditingController();
  ValueNotifier<String> currentValue = ValueNotifier("");
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

  @override
  void dispose() {
    otpController.dispose();
    currentValue.dispose();
    super.dispose();
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
        S.of(context).phoneVerification,
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
      showTitle: true,
      centerTitle: true,
      backgroundColor: AppColor.white,
    );
  }

  Widget buildView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          23.verticalSpace,
          Center(
            child: Image.asset(
              Assets.imageOtpVerification,
              height: 130.r,
              width: 117.w,
            ),
          ),
          24.verticalSpace,
          Text(
            S.of(context).pleaseEnterTheVerificationCodeWeSentToYourMobile,
            maxLines: 2,
            softWrap: false,
            textAlign: TextAlign.center,
            style: textRegular.copyWith(
                fontSize: 14.spMin, color: AppColor.grayColor),
          ).wrapPaddingHorizontal(15),
          7.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "+33- ",
                style: textMedium.copyWith(
                    fontSize: 14.spMin, color: AppColor.black),
              ),
              Text(
                "808-621-8522",
                style: textMedium.copyWith(
                    fontSize: 14.spMin, color: AppColor.black),
              ),
              11.horizontalSpace,
              GestureDetector(
                onTap: () {
                  appRouter.replace(ForgotPasswordRoute());
                },
                child: Image.asset(
                  Assets.imageEdit,
                  height: 13.r,
                  width: 13.w,
                ),
              ),
            ],
          ),
          20.verticalSpace,
          buildOtpForm(),
          21.verticalSpace,
          AppButton(
            radius: 5.r,
            Text(
              S.of(context).verify,
              style: textMedium.copyWith(
                  fontSize: 18.spMin, color: AppColor.white),
            ),
            () {
              if (formKey.currentState!.validate()) {
                if (widget.checked == true) {
                  appDB.isLogin = true;
                  appRouter.replaceAll([BottomNavigationBarRoute()]);
                } else {
                  appRouter.replaceAll([ResetPasswordRoute()]);
                }
              }
            },
            bgColor: AppColor.black,
            height: 55.r,
            width: double.infinity,
          ),
          12.verticalSpace,
          GestureDetector(
            onTap: () {
              otpController.text = "";
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.imageResend,
                  height: 13.r,
                  width: 15.w,
                ),
                6.horizontalSpace,
                Text(
                  S.of(context).resendCode,
                  style: textRegular.copyWith(fontSize: 15.spMin),
                ),
              ],
            ),
          ),
        ],
      ).wrapPaddingHorizontal(16),
    );
  }

  Widget buildOtpForm() {
    return Form(
      key: formKey,
      child: PinCodeTextField(
        errorTextSpace: 30,
        errorTextMargin: EdgeInsets.only(left: 90).r,
        validator: otpValidator,
        onChanged: (value) {
          currentValue.value = value;
        },
        autoDisposeControllers: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        hintCharacter: "⬤",
        hintStyle:
            textRegular.copyWith(fontSize: 10.spMin, color: AppColor.grayColor),
        textInputAction: TextInputAction.next,
        cursorColor: AppColor.black.withOpacity(0.5),
        animationDuration: Duration(milliseconds: 300),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderWidth: 1,
          selectedBorderWidth: 1,
          disabledBorderWidth: 1,
          activeBorderWidth: 1,
          inactiveBorderWidth: 1,
          activeColor: AppColor.grayColor.withOpacity(0.50),
          inactiveColor: AppColor.grayColor.withOpacity(0.50),
          selectedColor: AppColor.black,
          selectedFillColor: AppColor.white,
          activeFillColor: AppColor.white,
          inactiveFillColor: AppColor.white,
          borderRadius: BorderRadius.circular(5).r,
          fieldHeight: 55.r,
          fieldWidth: 55.r,
        ),
        enableActiveFill: true,
        textStyle:
            textSemiBold.copyWith(fontSize: 20.spMin, color: AppColor.black),
        keyboardType: TextInputType.number,
        controller: otpController,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        length: 4,
        appContext: context,
        obscureText: false,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
      ),
    ).wrapPaddingHorizontal(31);
  }
}
