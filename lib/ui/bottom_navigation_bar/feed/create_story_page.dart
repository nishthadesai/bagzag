import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/my_data/feed_story_data.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../router/app_router.dart';
import '../../../widget/app_text_filed.dart';
import '../../../widget/base_app_bar.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/show_message.dart';

@RoutePage()
class CreateStoryPage extends StatefulWidget {
  final String path;
  const CreateStoryPage({super.key, required this.path});

  @override
  State<CreateStoryPage> createState() => _CreateStoryPageState();
}

class _CreateStoryPageState extends State<CreateStoryPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController captionController = TextEditingController();
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
      bottomNavigationBar: AppButton(
          bgColor: AppColor.black,
          height: 55.r,
          width: double.infinity,
          radius: 5.r,
          Text(
            S.of(context).post,
            style:
                textMedium.copyWith(fontSize: 18.spMin, color: AppColor.white),
          ), () {
        if (formKey.currentState!.validate()) {
          feedStoryList.removeAt(0);
          // feedStoryList.insertAll(0, [
          //   FeedStoryData(
          //       "David",
          //       Assets.imageStudioPost1ProfilePic,
          //       false,
          //       File(widget.path),
          //       captionController.text,
          //       descController.text,
          //       "")
          // ]);
          showMessage("Story added succesfully");
          debugPrint(feedStoryList.length.toString());
          appRouter.maybePop();
        } else {}
      }).wrapPaddingOnly(left: 15, right: 15, bottom: 15),
    );
  }

  Widget buildAppBar() {
    return BaseAppBar(
      showTitle: true,
      centerTitle: true,
      backgroundColor: AppColor.white,
      titleWidget: Text(
        S.of(context).createStory,
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
          controller: captionController,
          validators: (value) {
            if (value!.isEmpty) {
              return S.of(context).pleaseEnterCaptionTitle;
            }
            return null;
          },
          keyboardType: TextInputType.name,
          keyboardAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          borderRadius: BorderRadius.circular(5).r,
          height: 55.r,
          label: '',
          hint: S.of(context).captionTitle,
          contentPadding: EdgeInsets.symmetric(horizontal: 23, vertical: 0).r,
        ),
        10.verticalSpace,
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
      ],
    ).wrapPaddingHorizontal(15);
  }
}
