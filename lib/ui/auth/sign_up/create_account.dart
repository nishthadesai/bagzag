import 'package:auto_route/auto_route.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isChecked = ValueNotifier(true);
  ValueNotifier<bool> isTapped = ValueNotifier(true);
  ValueNotifier<bool> isConfirmTapped = ValueNotifier(true);
  ValueNotifier<Country> _selectedDialogCountry =
      ValueNotifier(CountryPickerUtils.getCountryByIsoCode('CA'));
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

  Widget buildView() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            23.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.imageFbLogin,
                  height: 50.r,
                  width: 50.w,
                ),
                14.horizontalSpace,
                Image.asset(
                  Assets.imageGoogleLogin,
                  height: 50.r,
                  width: 50.w,
                ),
                14.horizontalSpace,
                Image.asset(
                  Assets.imageAppleLogin,
                  height: 50.r,
                  width: 50.w,
                ),
              ],
            ),
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
            ),
            20.verticalSpace,
            AppTextField(
              controller: firstNameController,
              validators: firstNameValidator,
              borderRadius: BorderRadius.circular(5).r,
              textCapitalization: TextCapitalization.words,
              keyboardAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              height: 55.r,
              label: '',
              hint: S.of(context).firstName,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 23, vertical: 16).r,
            ),
            10.verticalSpace,
            AppTextField(
              controller: lastNameController,
              validators: lastNameValidator,
              borderRadius: BorderRadius.circular(5).r,
              textCapitalization: TextCapitalization.words,
              keyboardAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              height: 55.r,
              label: '',
              hint: S.of(context).lastName,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 23, vertical: 16).r,
            ),
            10.verticalSpace,
            AppTextField(
              controller: emailController,
              validators: emailValidator,
              borderRadius: BorderRadius.circular(5).r,
              textCapitalization: TextCapitalization.none,
              keyboardAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              height: 55.r,
              label: '',
              hint: S.of(context).email,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 23, vertical: 16).r,
            ),
            10.verticalSpace,
            AppTextField(
              maxLength: 10,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: ValueListenableBuilder(
                  builder: (context, value, child) {
                    return GestureDetector(
                      onTap: () async => {
                        await _openCountryPickerDialog(),
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          17.horizontalSpace,
                          CountryPickerUtils.getDefaultFlagImage(value),
                          6.horizontalSpace,
                          Text(
                            '+${value.phoneCode}',
                            style: textSemiBold.copyWith(
                              fontSize: 16.spMin,
                            ),
                          ),
                          3.horizontalSpace,
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 15.r,
                            color: AppColor.black,
                          ),
                          3.horizontalSpace,
                          Text(
                            "| ",
                            style: textRegular.copyWith(
                                color: AppColor.grayColor, fontSize: 16.spMin),
                          ),
                        ],
                      ),
                    );
                  },
                  valueListenable: _selectedDialogCountry,
                ),
              ),
              controller: numberController,
              validators: mobileValidator,
              borderRadius: BorderRadius.circular(5).r,
              textCapitalization: TextCapitalization.none,
              keyboardAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              height: 55.r,
              label: '',
              hint: S.of(context).mobileNumber,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 23, vertical: 16).r,
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
                    ).wrapPaddingSymmetric(vertical: 20, horizontal: 17),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  keyboardAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  borderRadius: BorderRadius.circular(5).r,
                  height: 55.r,
                  label: '',
                  hint: S.of(context).newPassword,
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
                  obscureText: value == true ? true : false,
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
            17.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.r,
                  width: 24.r,
                  child: ValueListenableBuilder(
                    valueListenable: isChecked,
                    builder: (context, value, child) {
                      return Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5).r),
                        activeColor: AppColor.pinkColor,
                        value: value,
                        onChanged: (value) {
                          isChecked.value = value!;
                        },
                      );
                    },
                  ),
                ),
                9.horizontalSpace,
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: S.of(context).iAgreeTo,
                          style: textRegular.copyWith(
                              fontSize: 16.spMin, color: AppColor.grayColor),
                        ),
                        TextSpan(
                          text: S.of(context).termsCondition,
                          style: textMedium.copyWith(
                              fontSize: 16.spMin, color: AppColor.black),
                        ),
                        TextSpan(
                          text: S.of(context).and,
                          style: textRegular.copyWith(
                              fontSize: 16.spMin, color: AppColor.grayColor),
                        ),
                        TextSpan(
                          text: S.of(context).privacyPolicy,
                          style: textMedium.copyWith(
                              fontSize: 16.spMin, color: AppColor.black),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            37.verticalSpace,
            AppButton(
              radius: 5.r,
              Text(
                S.of(context).signUp,
                style: textMedium.copyWith(
                    fontSize: 18.spMin, color: AppColor.white),
              ),
              () {
                if (formKey.currentState!.validate()) {
                  if (isChecked.value == true) {
                    appRouter.push(PhoneVerificationRoute(checked: true));
                  } else {
                    showMessage(S.of(context).pleaseAcceptTermsConditions);
                  }
                }
              },
              bgColor: AppColor.black,
              height: 55.r,
              width: double.infinity,
            ),
            40.verticalSpace
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
          appRouter.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 17.r,
        ),
      ),
      titleWidget: Text(
        S.of(context).signUp,
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
      showTitle: true,
      centerTitle: true,
      backgroundColor: AppColor.white,
    );
  }

  Future _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Material(
              color: AppColor.transparent,
              child: GestureDetector(
                onTap: () {
                  appRouter.maybePop();
                },
                child: Icon(
                  Icons.close,
                  color: AppColor.white,
                ).wrapPaddingHorizontal(30),
              ),
            ),
            CountryPickerDialog(
              contentPadding: EdgeInsets.zero,
              titlePadding: const EdgeInsets.only(top: 8, bottom: 15),
              searchCursorColor: AppColor.grayColor,
              searchInputDecoration: InputDecoration(
                prefixIcon: Image.asset(
                  Assets.imageSearch,
                  height: 18.r,
                  width: 18.w,
                  color: AppColor.black,
                ).wrapPaddingAll(12),
                contentPadding: EdgeInsets.zero,
                hintText: "Search",
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide:
                      BorderSide(color: AppColor.grayColor.withOpacity(0.50)),
                  borderRadius: BorderRadius.circular(5).r,
                ),
                enabledBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide:
                      BorderSide(color: AppColor.grayColor.withOpacity(0.50)),
                  borderRadius: BorderRadius.circular(5).r,
                ),
                disabledBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide:
                      BorderSide(color: AppColor.grayColor.withOpacity(0.50)),
                  borderRadius: BorderRadius.circular(5).r,
                ),
              ),
              isSearchable: true,
              title: Text(
                S.of(context).chooseYourCountryCode,
                style: textMedium.copyWith(
                    fontSize: 20.spMin, color: AppColor.black),
              ),
              onValuePicked: (Country country) =>
                  _selectedDialogCountry.value = country,
              itemBuilder: _buildDialogItem,
              priorityList: [
                CountryPickerUtils.getCountryByIsoCode('CA'),
                CountryPickerUtils.getCountryByIsoCode('US'),
                CountryPickerUtils.getCountryByIsoCode('IN'),
              ],
            ),
          ],
        )),
      );
  Widget _buildDialogItem(Country country) => Column(
        children: [
          10.verticalSpace,
          Row(
            children: <Widget>[
              CountryPickerUtils.getDefaultFlagImage(country),
              10.horizontalSpace,
              Expanded(child: Text(country.name)),
              Spacer(),
              Text("+${country.phoneCode}"),
            ],
          ),
          5.verticalSpace,
          Divider(),
        ],
      );
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    numberController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
    _selectedDialogCountry.dispose();
    isChecked.dispose();
    isConfirmTapped.dispose();
    isTapped.dispose();
    super.dispose();
  }
}
