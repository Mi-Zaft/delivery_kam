import 'dart:convert';

import 'package:delivery_kam/constants.dart';
import 'package:delivery_kam/models/chat.dart';
import 'package:flutter/material.dart';
import 'package:delivery_kam/features/courier_chat/widgets/courier_message.dart';
import 'package:delivery_kam/features/courier_chat/widgets/user_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class CourierChatScreen extends StatefulWidget {
  final String orderId;
  const CourierChatScreen({super.key, required this.orderId});

  @override
  State<CourierChatScreen> createState() => _CourierChatScreenState();
}

class _CourierChatScreenState extends State<CourierChatScreen> {
  bool isConnected = false;
  late WebSocketChannel channel;
  late String apiToken;
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Message> messages = [];

  @override
  Future<void> initState() async {
    super.initState();
    connectWebSocket();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final apiToken = prefs.getString('jwt_token');
  }

  void connectWebSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse(AppConfig.chatUrl),
    );

    channel.stream.listen(
      (message) {
        isConnected = true;
        if (!message.contains('Request served by')) {
          setState(() {
            messages.add(
              Message(
                token: apiToken,
                role: 'courier',
                message: message,
                time: '',
                orderId: widget.orderId,
              ),
            );
          });
          _scrollToBottom();
        }
      },
      onDone: () {
        isConnected = false;
        connectWebSocket();
      },
      onError: (error) {
        isConnected = false;
      },
    );
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }

  void sendMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        messages.add(
          Message(
            token: apiToken,
            role: 'user',
            message: text,
            time: '',
            orderId: widget.orderId,
          ),
        );
      });
      _scrollToBottom();
      messageController.clear();
      channel.sink.add(json.encode(text));
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(title: const Text('Чат с курьером')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                if (message.role == 'courier') {
                  return CourierMessage(
                    text: message.message ?? '',
                    timeText: message.time ?? '',
                  );
                } else {
                  return UserMessage(
                    text: message.message ?? '',
                    timeText: message.time ?? '',
                  );
                }
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                'Курьер уже в пути',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(195, 195, 195, 1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12, top: 12),
                    padding: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(
                          color: const Color.fromRGBO(195, 195, 195, 1)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: screenWidth - 100,
                          child: TextField(
                            controller: messageController,
                            maxLines: 1,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              hintText: 'Сообщение',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if (isConnected == true) {
                              sendMessage(messageController.text);
                            }
                          },
                        ),
                      ],
                    ),
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
