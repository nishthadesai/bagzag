import '../../generated/assets.dart';

class MessagesData {
  final String dp;
  final String name;
  final String msg;
  final String time;

  MessagesData(
      {required this.dp,
      required this.name,
      required this.msg,
      required this.time});
}

List<MessagesData> messageDataList = [
  MessagesData(
      dp: Assets.imageStudioPost1ProfilePic,
      name: "Jacob Memes",
      msg: "Hello, Jacob",
      time: "2 min ago"),
  MessagesData(
      dp: Assets.imageMessageDp2,
      name: "Robert Wilson",
      msg: "Hello, Jacob",
      time: "2 min ago"),
  MessagesData(
      dp: Assets.imageMessageDp3,
      name: "Lissa Polo",
      msg: "Hello, Jacob",
      time: "2 min ago"),
];

//message_dp_2
