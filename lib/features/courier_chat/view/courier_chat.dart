import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:delivery_kam/features/courier_chat/widgets/courier_message.dart';
import 'package:delivery_kam/features/courier_chat/widgets/user_message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class CourierChatScreen extends StatefulWidget {
  const CourierChatScreen({super.key});

  @override
  State<CourierChatScreen> createState() => _CourierChatScreenState();
}

class _CourierChatScreenState extends State<CourierChatScreen> {
  bool isConnected = false;
  late WebSocketChannel channel;
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, String>> messages = [
    {
      'text':
          'Здравствуйте, я жду вас у второй двери третьего этажа. Вы уже близко?',
      'senderId': 'user',
      'time': '12:00'
    },
    {
      'text': 'Добрый день, через 5 минут буду у вас.',
      'senderId': 'courier',
      'time': '12:05'
    },
  ];

  @override
  void initState() {
    super.initState();
    connectWebSocket();
  }

  void connectWebSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse('ws://echo.websocket.org'),
    );

    channel.stream.listen(
      (message) {
        print('Received: $message');
        isConnected = true;
        if (!message.contains('Request served by')) {
          setState(() {
            messages.add({'text': message, 'senderId': 'courier'});
          });
          _scrollToBottom();
        }
      },
      onDone: () {
        isConnected = false;
        print('WebSocket closed');
        connectWebSocket();
      },
      onError: (error) {
        isConnected = false;
        print('Error: $error');
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
        messages.add({'text': text, 'senderId': 'user'});
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
                if (message['senderId'] == 'courier') {
                  return CourierMessage(
                    text: message['text'] ?? '',
                    timeText: message['time'] ?? '',
                  );
                } else {
                  return UserMessage(
                    text: message['text'] ?? '',
                    timeText: message['time'] ?? '',
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
            height: 80,
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
