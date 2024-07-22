import '../../generated/assets.dart';

class FeedCommentsData {
  final String image;
  final String name;
  final String Comment;
  final String time;

  FeedCommentsData(
      {required this.image,
      required this.name,
      required this.Comment,
      required this.time});
}

List feedCommentsList = [
  FeedCommentsData(
      image: Assets.imageStorypost2Profile,
      name: "Andria Jolly",
      Comment:
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et",
      time: "2 hr ago"),
  FeedCommentsData(
      image: Assets.imageCommentProfile2,
      name: "Marco Polo",
      Comment:
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et",
      time: "2 hr ago"),
  FeedCommentsData(
      image: Assets.imageCommentProfile3,
      name: "Mardi Lili",
      Comment:
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et",
      time: "2 hr ago"),
  FeedCommentsData(
      image: Assets.imageCommentProfile2,
      name: "Marco Polo",
      Comment:
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et",
      time: "2 hr ago"),
  FeedCommentsData(
      image: Assets.imageCommentProfile3,
      name: "Mardi Lili",
      Comment:
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et",
      time: "2 hr ago"),
];
