import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/message_model.dart';
import '../provider/chat_provider.dart';



class ChatScreen extends StatefulWidget {

  final String senderId;
  final String receiverId;

  const ChatScreen({
    super.key,
    required this.senderId,
    required this.receiverId,
  });

  @override
  State<ChatScreen> createState() =>
      _ChatScreenState();
}

class _ChatScreenState
    extends State<ChatScreen> {

  final TextEditingController _controller =
  TextEditingController();

  final ScrollController _scrollController =
  ScrollController();

  void _sendMessage() async {

    final text = _controller.text.trim();

    if (text.isEmpty) return;

    await context.read<ChatProvider>().sendMessage(
      senderId: widget.senderId,
      receiverId: widget.receiverId,
      text: text,
    );

    _controller.clear();

    Future.delayed(
      const Duration(milliseconds: 300),
          () {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final provider =
    context.watch<ChatProvider>();

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.receiverId),
      ),

      body: Column(
        children: [

          /// MESSAGE LIST
          Expanded(
            child: StreamBuilder<List<MessageModel>>(

              stream: provider.getMessages(
                widget.senderId,
                widget.receiverId,
              ),

              builder: (context, snapshot) {

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData ||
                    snapshot.data!.isEmpty) {

                  return const Center(
                    child: Text("No messages"),
                  );
                }

                final messages = snapshot.data!;

                return ListView.builder(

                  controller: _scrollController,

                  padding: const EdgeInsets.all(10),

                  itemCount: messages.length,

                  itemBuilder: (context, index) {

                    final message = messages[index];

                    final isMe =
                        message.senderId ==
                            widget.senderId;

                    return Align(

                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,

                      child: Container(

                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),

                        padding: const EdgeInsets.all(12),

                        constraints: BoxConstraints(
                          maxWidth:
                          MediaQuery.of(context)
                              .size
                              .width *
                              0.75,
                        ),

                        decoration: BoxDecoration(

                          color: isMe
                              ? Colors.blue
                              : Colors.grey.shade300,

                          borderRadius:
                          BorderRadius.only(

                            topLeft:
                            const Radius.circular(16),

                            topRight:
                            const Radius.circular(16),

                            bottomLeft:
                            Radius.circular(
                              isMe ? 16 : 0,
                            ),

                            bottomRight:
                            Radius.circular(
                              isMe ? 0 : 16,
                            ),
                          ),
                        ),

                        child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              message.text,

                              style: TextStyle(
                                color: isMe
                                    ? Colors.white
                                    : Colors.black,

                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(

                              "${message.time.hour}:${message.time.minute}",

                              style: TextStyle(
                                color: isMe
                                    ? Colors.white70
                                    : Colors.black54,

                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          /// MESSAGE INPUT
          Container(

            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),

            child: Row(
              children: [

                Expanded(
                  child: TextField(

                    controller: _controller,

                    decoration: InputDecoration(

                      hintText: "Type message...",

                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(30),
                      ),

                      contentPadding:
                      const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                CircleAvatar(

                  radius: 25,

                  child: IconButton(
                    icon: const Icon(Icons.send),

                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}