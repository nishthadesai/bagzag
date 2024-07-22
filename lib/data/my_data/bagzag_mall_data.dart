import 'package:flutter_demo_structure/generated/assets.dart';

import '../../generated/l10n.dart';

class BagzagMallData {
  final String image;
  final String name;

  BagzagMallData({required this.image, required this.name});
}

List bagzagMallList = [
  BagzagMallData(image: Assets.imageMallLibas, name: S.current.theLibas),
  BagzagMallData(image: Assets.imageMallMochi, name: S.current.mochaShoes),
  BagzagMallData(image: Assets.imageMallLibas, name: S.current.theNewShop),
  BagzagMallData(image: Assets.imageMallHappy, name: S.current.happyShop),
  BagzagMallData(image: Assets.imageMallBuyish, name: S.current.boyish),
  BagzagMallData(image: Assets.imageMallNewShop, name: S.current.theNewShop),
];
