import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/assets.dart';

class HomeCatListData {
  final Widget image;
  final String catName;

  HomeCatListData(this.image, this.catName);
}

List catList = [
  HomeCatListData(
      Image.asset(
        Assets.imageManCat,
        width: 87.w,
      ),
      "Man"),
  HomeCatListData(
      Image.asset(
        Assets.imageWomanCat,
        width: 98.w,
      ),
      "Women"),
  HomeCatListData(
      Image.asset(
        Assets.imageKidsCat,
        width: 56.w,
      ),
      "Kids"),
  HomeCatListData(
      Image.asset(
        Assets.imageBeautyCat,
        width: 105.w,
      ).wrapPaddingOnly(top: 10, right: 13, left: 3),
      "Beauty"),
  HomeCatListData(
      Image.asset(
        Assets.imageWomanCat,
        width: 98.w,
      ),
      "Women"),
  HomeCatListData(
      Image.asset(
        Assets.imageKidsCat,
        width: 56.w,
      ),
      "Kids"),
  HomeCatListData(
      Image.asset(
        Assets.imageBeautyCat,
        width: 105.w,
      ).wrapPaddingOnly(top: 10, right: 13, left: 3),
      "Beauty"),
];
