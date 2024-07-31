import 'package:flutter/cupertino.dart';

class MessageChatData {
  final ValueNotifier<bool> isSender;
  final dynamic msg;
  final String time;
  String? emoji;

  MessageChatData({
    required this.isSender,
    required this.msg,
    required this.time,
    this.emoji,
  });
}

Map<int, dynamic> messageChatMap = {
  0: [
    MessageChatData(
      isSender: ValueNotifier(true),
      msg: "Hi Jacob",
      time: "02:05",
    ),
    MessageChatData(
      isSender: ValueNotifier(true),
      msg: "Want to buy this product available?",
      time: "02:05",
    ),
    MessageChatData(
      isSender: ValueNotifier(false),
      msg: "Hi Jacob",
      time: "02:10",
    ),
    MessageChatData(
      isSender: ValueNotifier(false),
      msg: "Available Products: T-Shirt(300),Pents(100)",
      time: "02:10",
    ),
  ],
  1: [],
  2: [],
};
