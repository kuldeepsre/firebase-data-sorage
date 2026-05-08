import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/message_model.dart';


class ChatService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// CREATE ROOM ID
  String getRoomId(
      String senderId,
      String receiverId,
      ) {

    List<String> ids = [
      senderId,
      receiverId,
    ];

    ids.sort();

    return ids.join("_");
  }

  /// SEND MESSAGE
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String text,
  }) async {

    final roomId =
    getRoomId(senderId, receiverId);

    final message = MessageModel(
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      time: DateTime.now(),
    );

    await _firestore
        .collection("chat_rooms")
        .doc(roomId)
        .collection("messages")
        .add(
      message.toJson(),
    );
  }

  /// GET REALTIME MESSAGES
  Stream<List<MessageModel>> getMessages({
    required String senderId,
    required String receiverId,
  }) {

    final roomId =
    getRoomId(senderId, receiverId);

    return _firestore
        .collection("chat_rooms")
        .doc(roomId)
        .collection("messages")
        .orderBy("time",descending: false)
        .snapshots()
        .map((snapshot) {

      return snapshot.docs.map((doc) {

        return MessageModel.fromJson(
          doc.data(),
        );

      }).toList();
    });
  }
}