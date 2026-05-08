import 'package:flutter/material.dart';

import '../model/message_model.dart';
import '../services/chat_service.dart';


class ChatProvider extends ChangeNotifier {

  final ChatService _chatService =
  ChatService();

  /// GET REALTIME MESSAGES
  Stream<List<MessageModel>> getMessages(
      String senderId,
      String receiverId,
      ) {

    return _chatService.getMessages(
      senderId: senderId,
      receiverId: receiverId,
    );
  }

  /// SEND MESSAGE
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String text,
  }) async {

    if (text.trim().isEmpty) return;

    await _chatService.sendMessage(
      senderId: senderId,
      receiverId: receiverId,
      text: text,
    );

    notifyListeners();
  }
}