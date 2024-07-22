import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/generated/assets.dart';

class BestsellerData {
  final String offer;
  final String image;
  final ValueNotifier<bool> isLiked;
  final String productName;
  final String rating;
  final String tag;
  final String finalPrice;
  final String discount;

  BestsellerData(this.offer, this.image, this.isLiked, this.productName,
      this.rating, this.tag, this.finalPrice, this.discount);
}

List bestSellerListData = [
  BestsellerData("30% Off", Assets.imageBestsellerImg1, ValueNotifier(false),
      "Loose Textured T-Shirt", "4.5", "Free Shipping", "119.99", "159.99"),
  BestsellerData("", Assets.imageBestsellerImg2, ValueNotifier(true),
      "Loose Knit 3/4 Sleeve", "4.5", "Bestseller", "119.99", "159.99"),
  BestsellerData("", Assets.imageBestsellerImg1, ValueNotifier(false),
      "Loose Knit 3/4 Sleeve", "4.5", "", "119.99", "159.99")
];
