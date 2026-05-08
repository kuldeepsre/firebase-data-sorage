class MessageModel {

  final String senderId;
  final String receiverId;
  final String text;
  final DateTime time;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.time,
  });

  Map<String, dynamic> toJson() {

    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "text": text,
      "time": time.toIso8601String(),
    };
  }

  factory MessageModel.fromJson(
      Map<String, dynamic> json) {

    return MessageModel(
      senderId: json["senderId"] ?? "",
      receiverId: json["receiverId"] ?? "",
      text: json["text"] ?? "",
      time: DateTime.parse(json["time"]),
    );
  }
}