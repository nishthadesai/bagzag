import 'package:flutter_demo_structure/generated/assets.dart';

import '../../generated/l10n.dart';

enum MediaType { image, video }

class Stories {
  final dynamic story;
  final MediaType mediaType;
  final Duration duration;

  Stories(
      {required this.story, required this.mediaType, required this.duration});
}

class FeedStoryData {
  final String name;
  final String profilePic;
  final bool isVideo;
  final List<Stories> storyPic;
  final String productName;
  final String desc;
  final String video;

  FeedStoryData(this.name, this.profilePic, this.isVideo, this.storyPic,
      this.productName, this.desc, this.video);
}

List feedStoryList = [
  FeedStoryData(
      S.current.addStory,
      "",
      false,
      [
        Stories(
            story: Assets.imageStudioPost1ProfilePic,
            mediaType: MediaType.image,
            duration: Duration(seconds: 5))
      ],
      "",
      "",
      ""),
  FeedStoryData(
      S.current.michael,
      Assets.imageStory1Profile,
      true,
      [
        Stories(
          story: Assets.imageStory1,
          mediaType: MediaType.image,
          duration: Duration(seconds: 5),
        ),
        Stories(
          story: Assets.imageStoryVideo2,
          mediaType: MediaType.video,
          duration: Duration(seconds: 5),
        )
      ],
      S.current.fashionTShirt,
      S.current.loremIpsumDolorSitAmetConsecrateSadipscingElitrSedDiam,
      Assets.imageStoryVideo2),
  FeedStoryData(
      S.current.rubina,
      Assets.imageStory2Profile,
      false,
      [
        Stories(
            story: Assets.imageStory2,
            mediaType: MediaType.image,
            duration: Duration(seconds: 5))
      ],
      S.current.fashionTops,
      S.current.loremIpsumDolorSitAmetConsecrateSadipscingElitrSedDiam,
      ""),
  FeedStoryData(
      S.current.arzyan,
      Assets.imageStory3Profile,
      true,
      [
        Stories(
          story: Assets.imageStory3,
          mediaType: MediaType.image,
          duration: Duration(seconds: 5),
        ),
        Stories(
          story: Assets.imageStoryVideo1,
          mediaType: MediaType.video,
          duration: Duration(seconds: 5),
        )
      ],
      S.current.fashionTops,
      S.current.loremIpsumDolorSitAmetConsecrateSadipscingElitrSedDiam,
      Assets.imageStoryVideo1),
  FeedStoryData(
      S.current.michael,
      Assets.imageStory1Profile,
      false,
      [
        Stories(
            story: Assets.imageStory1,
            mediaType: MediaType.image,
            duration: Duration(seconds: 5))
      ],
      S.current.fashionTShirt,
      S.current.loremIpsumDolorSitAmetConsecrateSadipscingElitrSedDiam,
      ""),
  FeedStoryData(
      S.current.rubina,
      Assets.imageStory2Profile,
      false,
      [
        Stories(
            story: Assets.imageStory2,
            mediaType: MediaType.image,
            duration: Duration(seconds: 5))
      ],
      S.current.fashionTops,
      S.current.loremIpsumDolorSitAmetConsecrateSadipscingElitrSedDiam,
      ""),
  FeedStoryData(
      S.current.arzyan,
      Assets.imageStory3Profile,
      false,
      [
        Stories(
            story: Assets.imageStory3,
            mediaType: MediaType.image,
            duration: Duration(seconds: 5))
      ],
      S.current.fashionTops,
      S.current.loremIpsumDolorSitAmetConsecrateSadipscingElitrSedDiam,
      ""),
  FeedStoryData(
      S.current.michael,
      Assets.imageStory1Profile,
      false,
      [
        Stories(
            story: Assets.imageStory1,
            mediaType: MediaType.image,
            duration: Duration(seconds: 5))
      ],
      S.current.fashionTShirt,
      S.current.loremIpsumDolorSitAmetConsecrateSadipscingElitrSedDiam,
      ""),
];
