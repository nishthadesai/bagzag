import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../router/app_router.dart';
import '../../../values/colors.dart';
import '../../../values/style.dart';
import '../../../widget/app_text_filed.dart';
import '../../../widget/base_app_bar.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/show_message.dart';

@RoutePage()
class AddProductInfoPage extends StatefulWidget {
  final String path;
  const AddProductInfoPage({super.key, required this.path});

  @override
  State<AddProductInfoPage> createState() => _AddProductInfoPageState();
}

class _AddProductInfoPageState extends State<AddProductInfoPage> {
  // var category;
  ValueNotifier<String> category = ValueNotifier("");
  ValueNotifier<String> subCategory = ValueNotifier("");
  ValueNotifier<String> brand = ValueNotifier("");
  ValueNotifier<String> color = ValueNotifier("");
  ValueNotifier<String> size = ValueNotifier("");
  ValueNotifier<int> conditionValue = ValueNotifier(1);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> condition = [S.current.likeNew, S.current.good, "Fair"];
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final phoneRegex = RegExp(r'^\d{10}$');
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
        S.of(context).createPost,
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
          children: [
            14.verticalSpace,
            buildPostPhotoList(),
            16.verticalSpace,
            buildForm(),
          ],
        ),
      ),
    );
  }

  Widget buildPostPhotoList() {
    ValueNotifier<String> imagePath = ValueNotifier(widget.path);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          4,
          (index) {
            return ValueListenableBuilder(
              valueListenable: imagePath,
              builder: (context, value, child) {
                return Container(
                  height: 77.r,
                  width: 77.w,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColor.grayColor.withOpacity(0.50)),
                    borderRadius: BorderRadius.circular(5).r,
                  ),
                  child: value != '' && index == 0
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(5).r,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.file(
                                File(value),
                                width: 77.w,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                color: AppColor.black.withOpacity(0.40),
                                height: 77.r,
                                width: 77.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  imagePath.value = '';
                                },
                                child: Icon(
                                  Icons.close,
                                  color: AppColor.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Image.asset(
                          Assets.imageImage,
                          height: 25.r,
                          width: 25.w,
                        )),
                ).wrapPaddingOnly(left: index == 0 ? 15 : 0, right: 12);
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          textStyle:
              textMedium.copyWith(fontSize: 15.spMin, color: AppColor.black),
          controller: nameController,
          validators: (value) {
            if (value!.isEmpty) {
              return S.of(context).pleaseEnterProductName;
            }
            return null;
          },
          keyboardType: TextInputType.name,
          keyboardAction: TextInputAction.done,
          textCapitalization: TextCapitalization.words,
          borderRadius: BorderRadius.circular(5).r,
          height: 55.r,
          label: '',
          hint: "Product Name",
          contentPadding: EdgeInsets.symmetric(horizontal: 23, vertical: 0).r,
        ),
        9.verticalSpace,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5).r,
              border: Border.all(color: AppColor.grayColor.withOpacity(0.50))),
          height: 43.r,
          width: double.infinity,
          child: GestureDetector(
            onTap: () async {
              var result =
                  await appRouter.push(CreatePostCategoryDetailsRoute());
              category.value = result.toString();
            },
            child: SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                    valueListenable: category,
                    builder: (context, value, child) {
                      return value.isEmpty || value == null
                          ? Text(
                              S.of(context).category,
                              style: textRegular.copyWith(
                                  fontSize: 15.spMin,
                                  color: AppColor.grayColor),
                            )
                          : Text(
                              value,
                              style: textMedium.copyWith(
                                  fontSize: 15.spMin, color: AppColor.black),
                            );
                    },
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20.r,
                    color: AppColor.grayColor,
                  ),
                ],
              ).wrapPaddingOnly(top: 10, left: 22, right: 22),
            ),
          ),
        ),
        10.verticalSpace,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5).r,
              border: Border.all(color: AppColor.grayColor.withOpacity(0.50))),
          height: 43.r,
          width: double.infinity,
          child: GestureDetector(
            onTap: () async {
              var result =
                  await appRouter.push(CreatePostSubCategoryDetailsRoute());
              subCategory.value = result.toString();
            },
            child: SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                    valueListenable: subCategory,
                    builder: (context, value, child) {
                      return value.isEmpty || value == null
                          ? Text(
                              S.of(context).subcategory,
                              style: textRegular.copyWith(
                                  fontSize: 15.spMin,
                                  color: AppColor.grayColor),
                            )
                          : Text(
                              value,
                              style: textMedium.copyWith(
                                  fontSize: 15.spMin, color: AppColor.black),
                            );
                    },
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20.r,
                    color: AppColor.grayColor,
                  ),
                ],
              ).wrapPaddingOnly(top: 10, left: 22, right: 22),
            ),
          ),
        ),
        10.verticalSpace,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5).r,
              border: Border.all(color: AppColor.grayColor.withOpacity(0.50))),
          height: 43.r,
          width: double.infinity,
          child: GestureDetector(
            onTap: () async {
              var result = await appRouter.push(CreatePostBrandDetailsRoute());
              brand.value = result.toString();
            },
            child: SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                    valueListenable: brand,
                    builder: (context, value, child) {
                      return value.isEmpty || value == null
                          ? Text(
                              S.of(context).brand,
                              style: textRegular.copyWith(
                                  fontSize: 15.spMin,
                                  color: AppColor.grayColor),
                            )
                          : Text(
                              value,
                              style: textMedium.copyWith(
                                  fontSize: 15.spMin, color: AppColor.black),
                            );
                    },
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20.r,
                    color: AppColor.grayColor,
                  ),
                ],
              ).wrapPaddingOnly(top: 10, left: 22, right: 22),
            ),
          ),
        ),
        10.verticalSpace,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5).r,
              border: Border.all(color: AppColor.grayColor.withOpacity(0.50))),
          height: 43.r,
          width: double.infinity,
          child: GestureDetector(
            onTap: () async {
              var result = await appRouter.push(CreatePostColorDetailsRoute());
              color.value = result.toString();
            },
            child: SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                    valueListenable: color,
                    builder: (context, value, child) {
                      return value.isEmpty || value == null
                          ? Text(
                              "Color (Optional)",
                              style: textRegular.copyWith(
                                  fontSize: 15.spMin,
                                  color: AppColor.grayColor),
                            )
                          : Text(
                              value,
                              style: textMedium.copyWith(
                                  fontSize: 15.spMin, color: AppColor.black),
                            );
                    },
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20.r,
                    color: AppColor.grayColor,
                  ),
                ],
              ).wrapPaddingOnly(top: 10, left: 22, right: 22),
            ),
          ),
        ),
        10.verticalSpace,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5).r,
              border: Border.all(color: AppColor.grayColor.withOpacity(0.50))),
          height: 43.r,
          width: double.infinity,
          child: GestureDetector(
            onTap: () async {
              var result = await appRouter.push(CreatePostSizeDetailsRoute());
              size.value = result.toString();
            },
            child: SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                    valueListenable: size,
                    builder: (context, value, child) {
                      return value.isEmpty || value == null
                          ? Text(
                              "Size (Optional)",
                              style: textRegular.copyWith(
                                  fontSize: 15.spMin,
                                  color: AppColor.grayColor),
                            )
                          : Text(
                              value,
                              style: textMedium.copyWith(
                                  fontSize: 15.spMin, color: AppColor.black),
                            );
                    },
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20.r,
                    color: AppColor.grayColor,
                  ),
                ],
              ).wrapPaddingOnly(top: 10, left: 22, right: 22),
            ),
          ),
        ),
        13.verticalSpace,
        Text(
          "Condition",
          style: textMedium.copyWith(fontSize: 16.spMin, color: AppColor.black),
        ),
        9.verticalSpace,
        Row(
          children: List.generate(
            3,
            (index) {
              return ValueListenableBuilder(
                valueListenable: conditionValue,
                builder: (context, value, child) {
                  return ChoiceChip(
                    shadowColor: AppColor.transparent,
                    selectedShadowColor: AppColor.transparent,
                    elevation: 0,
                    surfaceTintColor: AppColor.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: value == index
                                ? AppColor.black
                                : AppColor.grayColor),
                        borderRadius: BorderRadius.circular(4).r),
                    backgroundColor: AppColor.white,
                    selectedColor: AppColor.white,
                    label: Text(
                      condition[index],
                      style: textRegular.copyWith(
                          fontSize: 14.spMin,
                          color: value == index
                              ? AppColor.black
                              : AppColor.grayColor),
                    ),
                    selected: value == index,
                    onSelected: (val) {
                      conditionValue.value = (val ? index : null)!;
                    },
                  ).wrapPaddingRight(8);
                },
              );
            },
          ),
        ),
        12.verticalSpace,
        AppTextField(
          validators: (value) {
            if (value!.isEmpty) {
              return S.of(context).pleaseEnterDescription;
            }
            return null;
          },
          minLines: 6,
          maxLines: 6,
          controller: descController,
          keyboardType: TextInputType.multiline,
          keyboardAction: TextInputAction.newline,
          textCapitalization: TextCapitalization.words,
          borderRadius: BorderRadius.circular(5).r,
          height: 175.r,
          label: '',
          hint: S.of(context).description,
          contentPadding: EdgeInsets.symmetric(horizontal: 23, vertical: 15).r,
        ),
        10.verticalSpace,
        AppTextField(
          textStyle:
              textMedium.copyWith(fontSize: 15.spMin, color: AppColor.black),
          controller: priceController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          validators: (value) {
            if (value!.isEmpty) {
              return S.of(context).pleaseEnterSellingPrice;
            }
            return null;
          },
          keyboardType: TextInputType.number,
          keyboardAction: TextInputAction.next,
          textCapitalization: TextCapitalization.none,
          borderRadius: BorderRadius.circular(5).r,
          height: 55.r,
          label: '',
          hint: "Selling Price",
          contentPadding: EdgeInsets.symmetric(horizontal: 23, vertical: 0).r,
        ),
        10.verticalSpace,
        AppTextField(
          textStyle:
              textMedium.copyWith(fontSize: 15.spMin, color: AppColor.black),
          controller: fullNameController,
          validators: (value) {
            if (value!.isEmpty) {
              return "Please enter user full name";
            }
            return null;
          },
          keyboardType: TextInputType.name,
          keyboardAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          borderRadius: BorderRadius.circular(5).r,
          height: 55.r,
          label: '',
          hint: "User Full Name",
          contentPadding: EdgeInsets.symmetric(horizontal: 23, vertical: 0).r,
        ),
        10.verticalSpace,
        AppTextField(
          textStyle:
              textMedium.copyWith(fontSize: 15.spMin, color: AppColor.black),
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
          keyboardType: TextInputType.emailAddress,
          keyboardAction: TextInputAction.done,
          textCapitalization: TextCapitalization.none,
          borderRadius: BorderRadius.circular(5).r,
          height: 55.r,
          label: '',
          hint: S.of(context).emailPhoneNumber,
          contentPadding: EdgeInsets.symmetric(horizontal: 23, vertical: 0).r,
        ),
        15.verticalSpace,
        AppButton(
          bgColor: AppColor.black,
          height: 55.r,
          width: double.infinity,
          radius: 5.r,
          Text(
            S.of(context).post,
            style:
                textMedium.copyWith(fontSize: 18.spMin, color: AppColor.white),
          ),
          () {
            if (formKey.currentState!.validate()) {
              if (category.value.isNotEmpty &&
                  category.value != null &&
                  subCategory.value.isNotEmpty &&
                  subCategory.value != null &&
                  brand.value.isNotEmpty &&
                  brand.value != null) {
                appRouter.replaceAll([BottomNavigationBarRoute()]);
                showMessage(S.of(context).yourPostUploadedSuccessfully);
              } else {
                showMessage(
                    S.of(context).pleaseEnterCategorySubcategoryBrandDetails);
              }
            }
          },
        ),
        15.verticalSpace,
      ],
    ).wrapPaddingHorizontal(15);
  }

  @override
  void dispose() {
    category.dispose();
    subCategory.dispose();
    brand.dispose();
    color.dispose();
    size.dispose();
    conditionValue.dispose();
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
