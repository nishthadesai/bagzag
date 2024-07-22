import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';

class RecentViewData {
  final String offer;
  final Image image;
  final ValueNotifier<bool> isLiked;
  final String productName;
  final String rating;
  final String tag;
  final String finalPrice;
  final String discount;

  RecentViewData(this.offer, this.image, this.isLiked, this.productName,
      this.rating, this.tag, this.finalPrice, this.discount);
}

List recentViewBuilderDataList = [
  RecentViewData(
      "30% Off",
      Image.asset(
        Assets.imageRecentViewImg1,
        height: 139.r,
        width: 169.r,
      ),
      ValueNotifier(true),
      S.current.looseTexturedTshirt,
      "4.5",
      S.current.freeShipping,
      "119.99",
      "159.99"),
  RecentViewData(
      "",
      Image.asset(
        Assets.imageRecentViewImg2,
        height: 139.r,
        width: 169.r,
      ),
      ValueNotifier(true),
      S.current.looseTexturedTshirt,
      "4.5",
      S.current.bestseller,
      "119.99",
      "159.99"),
  RecentViewData(
      "30% Off",
      Image.asset(
        Assets.imageRecentViewImg3,
        height: 130.r,
        width: 169.r,
      ),
      ValueNotifier(true),
      S.current.looseTexturedTshirt,
      "4.5",
      S.current.freeShipping,
      "119.99",
      "159.99"),
  RecentViewData(
      "",
      Image.asset(
        Assets.imageRecentViewImg4,
        height: 130.r,
        width: 169.r,
      ),
      ValueNotifier(true),
      S.current.looseTexturedTshirt,
      "4.5",
      S.current.bestseller,
      "119.99",
      "159.99"),
];
