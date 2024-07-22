import 'package:flutter/material.dart';

import '../../generated/assets.dart';

class StudioData {
  final String profileImage;
  final String userName;
  ValueNotifier<bool> isFollowed;
  final String lastSeen;
  final List<String> postImage;
  ValueNotifier<int> currentIndex;
  ValueNotifier<bool> isLiked;
  ValueNotifier<bool> isSaved;
  final String desc;

  StudioData(
      {required this.profileImage,
      required this.userName,
      required this.isFollowed,
      required this.lastSeen,
      required this.currentIndex,
      required this.postImage,
      required this.isLiked,
      required this.isSaved,
      required this.desc});
}

List studioDataList = [
  StudioData(
      profileImage: Assets.imageStudioPost1ProfilePic,
      userName: "Michaele Lusiada",
      isFollowed: ValueNotifier(false),
      lastSeen: "2 min ago",
      postImage: [
        Assets.imageStudioPost1,
        Assets.imageStudioPost1,
        Assets.imageStudioPost1,
        Assets.imageStudioPost1,
      ],
      isLiked: ValueNotifier(false),
      isSaved: ValueNotifier(false),
      desc:
          "Lorem ipsum dolor sit amet, consecrate disciplining elite, sed diam nonnull usermod temper invidious outta Flutter is Google’s mobile UI open source framework to build high-quality native. ",
      currentIndex: ValueNotifier(0)),
  StudioData(
      profileImage: Assets.imageStudioPost2Profile,
      userName: "Mochi Shoes",
      isFollowed: ValueNotifier(false),
      lastSeen: "2 min ago",
      postImage: [
        Assets.imageStudioPost2,
        Assets.imageStudioPost2,
        Assets.imageStudioPost2,
        Assets.imageStudioPost2,
      ],
      isLiked: ValueNotifier(false),
      isSaved: ValueNotifier(false),
      desc:
          "Lorem ipsum dolor sit amet, consecrate disciplining elite, sed diam nonnull usermod temper invidious outta Flutter is Google’s mobile UI open source framework to build high-quality native. ",
      currentIndex: ValueNotifier(0)),
  StudioData(
      profileImage: Assets.imageStudioPost3Profile,
      userName: "Mochi Shoes",
      isFollowed: ValueNotifier(false),
      lastSeen: "2 min ago",
      postImage: [
        Assets.imageStudioPost3,
        Assets.imageStudioPost3,
        Assets.imageStudioPost3,
        Assets.imageStudioPost3,
      ],
      isLiked: ValueNotifier(false),
      isSaved: ValueNotifier(false),
      desc:
          "Lorem ipsum dolor sit amet, consecrate disciplining elite, sed diam nonnull usermod temper invidious outta Flutter is Google’s mobile UI open source framework to build high-quality native. ",
      currentIndex: ValueNotifier(0)),
  StudioData(
      profileImage: Assets.imageStudioPost1ProfilePic,
      userName: "Michaele Lusiada",
      isFollowed: ValueNotifier(false),
      lastSeen: "2 min ago",
      postImage: [
        Assets.imageStudioPost1,
        Assets.imageStudioPost1,
        Assets.imageStudioPost1,
        Assets.imageStudioPost1,
      ],
      isLiked: ValueNotifier(false),
      isSaved: ValueNotifier(false),
      desc:
          "Lorem ipsum dolor sit amet, consecrate disciplining elite, sed diam nonnull usermod temper invidious outta Flutter is Google’s mobile UI open source framework to build high-quality native. ",
      currentIndex: ValueNotifier(0)),
  StudioData(
      profileImage: Assets.imageStudioPost2Profile,
      userName: "Mochi Shoes",
      isFollowed: ValueNotifier(false),
      lastSeen: "2 min ago",
      postImage: [
        Assets.imageStudioPost2,
        Assets.imageStudioPost2,
        Assets.imageStudioPost2,
        Assets.imageStudioPost2,
      ],
      isLiked: ValueNotifier(false),
      isSaved: ValueNotifier(false),
      desc:
          "Lorem ipsum dolor sit amet, consecrate disciplining elite, sed diam nonnull usermod temper invidious outta Flutter is Google’s mobile UI open source framework to build high-quality native. ",
      currentIndex: ValueNotifier(0)),
  StudioData(
      profileImage: Assets.imageStudioPost3Profile,
      userName: "Mochi Shoes",
      isFollowed: ValueNotifier(false),
      lastSeen: "2 min ago",
      postImage: [
        Assets.imageStudioPost3,
        Assets.imageStudioPost3,
        Assets.imageStudioPost3,
        Assets.imageStudioPost3,
      ],
      isLiked: ValueNotifier(false),
      isSaved: ValueNotifier(false),
      desc:
          "Lorem ipsum dolor sit amet, consecrate disciplining elite, sed diam nonnull usermod temper invidious outta Flutter is Google’s mobile UI open source framework to build high-quality native. ",
      currentIndex: ValueNotifier(0)),
];
