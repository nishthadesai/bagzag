import 'package:flutter_demo_structure/generated/assets.dart';

import '../../generated/l10n.dart';

class FeedStoryData {
  final String name;
  final String profilePic;
  final bool isVideo;
  final dynamic storyPic;
  final String productName;
  final String desc;
  final String video;

  FeedStoryData(this.name, this.profilePic, this.isVideo, this.storyPic,
      this.productName, this.desc, this.video);
}

List feedStoryList = [
  FeedStoryData(S.current.addStory, "", false,
      Assets.imageStudioPost1ProfilePic, "", "", ""),
  FeedStoryData(
      S.current.michael,
      Assets.imageStory1Profile,
      true,
      Assets.imageStory1,
      S.current.fashionTShirt,
      S.current.loremIpsumDolorSitAmetConsecrateSadipscingElitrSedDiam,
      Assets.imageStoryVideo2),
  FeedStoryData(
      S.current.rubina,
      Assets.imageStory2Profile,
      false,
      Assets.imageStory2,
      S.current.fashionTops,
      S.current.loremIpsumDolorSitAmetConsecrateSadipscingElitrSedDiam,
      ""),
  FeedStoryData(
      S.current.arzyan,
      Assets.imageStory3Profile,
      true,
      Assets.imageStory3,
      S.current.fashionTops,
      S.current.loremIpsumDolorSitAmetConsecrateSadipscingElitrSedDiam,
      Assets.imageStoryVideo1),
  FeedStoryData(
      S.current.michael,
      Assets.imageStory1Profile,
      false,
      Assets.imageStory1,
      S.current.fashionTShirt,
      S.current.loremIpsumDolorSitAmetConsecrateSadipscingElitrSedDiam,
      ""),
  FeedStoryData(
      S.current.rubina,
      Assets.imageStory2Profile,
      false,
      Assets.imageStory2,
      S.current.fashionTops,
      S.current.loremIpsumDolorSitAmetConsecrateSadipscingElitrSedDiam,
      ""),
  FeedStoryData(
      S.current.arzyan,
      Assets.imageStory3Profile,
      false,
      Assets.imageStory3,
      S.current.fashionTops,
      S.current.loremIpsumDolorSitAmetConsecrateSadipscingElitrSedDiam,
      ""),
  FeedStoryData(
      S.current.michael,
      Assets.imageStory1Profile,
      false,
      Assets.imageStory1,
      S.current.fashionTShirt,
      S.current.loremIpsumDolorSitAmetConsecrateSadipscingElitrSedDiam,
      ""),
];
