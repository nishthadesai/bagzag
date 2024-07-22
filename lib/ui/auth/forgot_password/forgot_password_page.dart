import 'package:auto_route/auto_route.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_demo_structure/widget/base_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/l10n.dart';
import '../../../router/app_router.dart';
import '../../../widget/app_text_filed.dart';
import '../../../widget/button_widget.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ValueNotifier<Country> _selectedDialogCountry =
      ValueNotifier(CountryPickerUtils.getCountryByIsoCode('CA'));

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

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
        "Forgot Password",
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
      showTitle: true,
      centerTitle: true,
      backgroundColor: AppColor.white,
    );
  }

  Widget buildView() {
    double height = MediaQuery.of(context).size.height;
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            23.verticalSpace,
            Center(
              child: Image.asset(
                Assets.imageVerification,
                height: 130.r,
                width: 117.w,
              ),
            ),
            24.verticalSpace,
            Text(
              S.of(context).enterYourEmailAddressOrMobileNumberWellSendYou,
              style: textRegular.copyWith(
                  fontSize: 14.spMin, color: AppColor.grayColor),
              textAlign: TextAlign.center,
              maxLines: 2,
              softWrap: false,
            ).wrapPaddingHorizontal(28),
            15.verticalSpace,
            TabBar(
              indicatorPadding: EdgeInsets.only(right: 15),
              indicatorColor: AppColor.pinkColor,
              tabAlignment: TabAlignment.center,
              dividerColor: AppColor.white,
              dividerHeight: 0,
              labelPadding: EdgeInsets.only(right: 15),
              labelColor: AppColor.pinkColor,
              unselectedLabelColor: AppColor.grayColor,
              labelStyle: textRegular.copyWith(
                fontSize: 14.spMin,
              ),
              unselectedLabelStyle: textRegular.copyWith(fontSize: 14.spMin),
              controller: tabController,
              tabs: [
                Tab(
                  height: 21,
                  child: Text(S.of(context).email),
                ),
                Tab(
                  height: 21,
                  child: Text(S.of(context).mobile),
                ),
              ],
            ),
            15.verticalSpace,
            Container(
              height: height < 600 ? 192.r : 165.r,
              child: TabBarView(
                controller: tabController,
                children: [
                  buildEmailTab(),
                  buildMobileTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmailTab() {
    return Column(
      children: [
        AppTextField(
          controller: emailController,
          validators: emailValidator,
          borderRadius: BorderRadius.circular(5).r,
          textCapitalization: TextCapitalization.none,
          keyboardAction: TextInputAction.done,
          keyboardType: TextInputType.emailAddress,
          height: 55.r,
          label: '',
          hint: S.of(context).email,
          contentPadding: EdgeInsets.symmetric(horizontal: 23, vertical: 16).r,
        ),
        15.verticalSpace,
        AppButton(
          radius: 5.r,
          Text(
            S.of(context).submit,
            style:
                textMedium.copyWith(fontSize: 18.spMin, color: AppColor.white),
          ),
          () {
            if (formKey.currentState!.validate()) {
              emailController.text = '';
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10).r),
                    contentPadding: EdgeInsets.zero,
                    backgroundColor: AppColor.white,
                    content: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10).r,
                        color: AppColor.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.imageCheckGmail,
                            height: 103.r,
                            width: 142.w,
                          ),
                          23.verticalSpace,
                          Text(
                            S.of(context).checkYourEmail,
                            style: textMedium.copyWith(
                                fontSize: 25.spMin, color: AppColor.black),
                          ),
                          10.verticalSpace,
                          Text(
                            S
                                .of(context)
                                .weHaveSentInstructionsOnHowToResetThePassword,
                            maxLines: 2,
                            softWrap: false,
                            textAlign: TextAlign.center,
                            style: textRegular.copyWith(
                                fontSize: 14.spMin, color: AppColor.grayColor),
                          ),
                          16.verticalSpace,
                          AppButton(
                            radius: 5.r,
                            Text(
                              S.of(context).ok,
                              style: textMedium.copyWith(
                                  fontSize: 18.spMin, color: AppColor.white),
                            ),
                            () {
                              appRouter.replaceAll([WalkThroughRoute()]);
                            },
                            bgColor: AppColor.black,
                            height: 55.r,
                            width: double.infinity,
                          ),
                          26.verticalSpace,
                        ],
                      ).wrapPaddingOnly(top: 28, left: 27, right: 27),
                    ),
                  );
                },
              );
            }
          },
          bgColor: AppColor.black,
          height: 55.r,
          width: double.infinity,
        ),
      ],
    ).wrapPaddingHorizontal(16);
  }

  Widget buildMobileTab() {
    return Column(
      children: [
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
          keyboardAction: TextInputAction.done,
          keyboardType: TextInputType.phone,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          height: 55.r,
          label: '',
          hint: S.of(context).mobileNumber,
          contentPadding: EdgeInsets.symmetric(horizontal: 23, vertical: 16).r,
        ),
        15.verticalSpace,
        AppButton(
          radius: 5.r,
          Text(
            S.of(context).getOtp,
            style:
                textMedium.copyWith(fontSize: 18.spMin, color: AppColor.white),
          ),
          () {
            if (formKey.currentState!.validate()) {
              numberController.text = "";
              appRouter.replace(PhoneVerificationRoute(checked: false));
            }
          },
          bgColor: AppColor.black,
          height: 55.r,
          width: double.infinity,
        ),
      ],
    ).wrapPaddingHorizontal(16);
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
    tabController?.dispose();
    emailController.dispose();
    numberController.dispose();
    _selectedDialogCountry.dispose();
    super.dispose();
  }
}
