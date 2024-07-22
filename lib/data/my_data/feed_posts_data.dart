import 'package:flutter/material.dart';

import '../../generated/assets.dart';

class FeedPostData {
  final String profileImage;
  final String userName;
  final int products;
  final String lastSeen;
  final bool isNew;
  final List<String> postImage;
  ValueNotifier<int> currentIndex;
  ValueNotifier<bool> isLiked;
  ValueNotifier<bool> isSaved;
  final String desc;

  FeedPostData(
      {required this.profileImage,
      required this.userName,
      required this.products,
      required this.lastSeen,
      required this.isNew,
      required this.currentIndex,
      required this.postImage,
      required this.isLiked,
      required this.isSaved,
      required this.desc});
}

List feedPostDataList = [
  FeedPostData(
      profileImage: Assets.imageStorypost1Profile,
      userName: "The Adination",
      products: 10,
      lastSeen: "2 min ago",
      isNew: true,
      postImage: [
        Assets.imageFeedPost1,
        Assets.imageFeedPost1,
        Assets.imageFeedPost1,
        Assets.imageFeedPost1,
      ],
      isLiked: ValueNotifier(false),
      isSaved: ValueNotifier(false),
      desc:
          "Lorem ipsum dolor sit amet, consecrate disciplining elite, sed diam nonnull usermod temper invidious outta Flutter is Google’s mobile UI open source framework to build high-quality native. ",
      currentIndex: ValueNotifier(0)),
  FeedPostData(
      profileImage: Assets.imageStorypost2Profile,
      userName: "The Fashion",
      products: 10,
      lastSeen: "2 min ago",
      isNew: false,
      postImage: [
        Assets.imageFeedPost2,
        Assets.imageFeedPost2,
        Assets.imageFeedPost2,
        Assets.imageFeedPost2,
      ],
      isLiked: ValueNotifier(false),
      isSaved: ValueNotifier(false),
      desc:
          "Lorem ipsum dolor sit amet, consecrate disciplining elite, sed diam nonnull usermod temper invidious outta Flutter is Google’s mobile UI open source framework to build high-quality native. ",
      currentIndex: ValueNotifier(0)),
  FeedPostData(
      profileImage: Assets.imageStorypost2Profile,
      userName: "The Fashion",
      products: 10,
      lastSeen: "2 min ago",
      isNew: false,
      postImage: [
        Assets.imageFeedPost3,
        Assets.imageFeedPost3,
        Assets.imageFeedPost3,
        Assets.imageFeedPost3,
      ],
      isLiked: ValueNotifier(false),
      isSaved: ValueNotifier(false),
      desc:
          "Lorem ipsum dolor sit amet, consecrate disciplining elite, sed diam nonnull usermod temper invidious outta Flutter is Google’s mobile UI open source framework to build high-quality native. ",
      currentIndex: ValueNotifier(0)),
];
