import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController descController = TextEditingController();
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
        "Contact Us",
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
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            16.verticalSpace,
            Center(
              child: Image.asset(
                Assets.imageContactUs,
                height: 137.r,
                width: 162.w,
              ),
            ),
            24.verticalSpace,
            Text(
              "Please Feel Free To Talk To Us If You Have Any Questions. We Endeavour To Answer Within 24 Hours.",
              style: textRegular.copyWith(
                  fontSize: 14.spMin, color: AppColor.grayColor),
              maxLines: 3,
              textAlign: TextAlign.center,
            ).wrapPaddingHorizontal(10),
            20.verticalSpace,
            AppTextField(
              controller: emailController,
              validators: emailValidator,
              keyboardType: TextInputType.emailAddress,
              keyboardAction: TextInputAction.next,
              textCapitalization: TextCapitalization.none,
              borderRadius: BorderRadius.circular(5).r,
              height: 55.r,
              label: '',
              hint: S.of(context).email,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 23, vertical: 0).r,
            ),
            10.verticalSpace,
            AppTextField(
              validators: (value) {
                if (value!.isEmpty) {
                  return S.of(context).pleaseEnterSubject;
                }
                return null;
              },
              controller: subjectController,
              keyboardType: TextInputType.name,
              keyboardAction: TextInputAction.next,
              textCapitalization: TextCapitalization.none,
              borderRadius: BorderRadius.circular(5).r,
              height: 55.r,
              label: '',
              hint: S.of(context).subject,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 23, vertical: 0).r,
            ),
            10.verticalSpace,
            AppTextField(
              validators: (value) {
                if (value!.isEmpty) {
                  return S.of(context).pleaseEnterDescription;
                }
                return null;
              },
              minLines: 10,
              maxLines: 10,
              controller: descController,
              keyboardType: TextInputType.multiline,
              keyboardAction: TextInputAction.newline,
              textCapitalization: TextCapitalization.none,
              borderRadius: BorderRadius.circular(5).r,
              height: 175.r,
              label: '',
              hint: S.of(context).description,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 23, vertical: 15).r,
            ),
            16.verticalSpace,
            AppButton(
              bgColor: AppColor.black,
              height: 55.r,
              width: double.infinity,
              radius: 5.r,
              Text(
                S.of(context).submit,
                style: textMedium.copyWith(
                    fontSize: 18.spMin, color: AppColor.white),
              ),
              () {
                if (formKey.currentState!.validate()) {
                  appRouter.maybePop();
                  showMessage(S.of(context).thankyou);
                } else {}
              },
            ),
            15.verticalSpace,
          ],
        ).wrapPaddingHorizontal(16),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    subjectController.dispose();
    descController.dispose();
    super.dispose();
  }
}
