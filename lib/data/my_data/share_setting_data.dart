import 'package:flutter/cupertino.dart';
import 'package:flutter_demo_structure/generated/assets.dart';

class SharingSettingsData {
  final String image;
  final String name;
  final ValueNotifier<bool> isConnect;

  SharingSettingsData(
      {required this.image, required this.name, required this.isConnect});
}

List<SharingSettingsData> sharingSettingList = [
  SharingSettingsData(
      image: Assets.imagePinterest,
      name: 'Pinterest',
      isConnect: ValueNotifier(false)),
  SharingSettingsData(
      image: Assets.imageTwitter,
      name: 'Twitter',
      isConnect: ValueNotifier(false)),
  SharingSettingsData(
      image: Assets.imageFacebook,
      name: 'Facebook',
      isConnect: ValueNotifier(false)),
  SharingSettingsData(
      image: Assets.imageInstagram,
      name: 'Instagram',
      isConnect: ValueNotifier(true)),
];
