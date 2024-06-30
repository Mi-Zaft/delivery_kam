import 'package:flutter/material.dart';
import 'package:delivery_kam/features/courier_chat/widgets/courier_message.dart';
import 'package:delivery_kam/features/courier_chat/widgets/user_message.dart';

class CourierChatScreen extends StatefulWidget {
  const CourierChatScreen({Key? key}) : super(key: key);

  @override
  State<CourierChatScreen> createState() => _CourierChatScreenState();
}

class _CourierChatScreenState extends State<CourierChatScreen> {
  final TextEditingController messageController = TextEditingController();
  List<Map<String, String>> messages = [
    {
      'text':
          'Здравствуйте, я жду вас у второй двери третьего этажа. Вы уже близко?',
      'senderId': 'user'
    },
    {'text': 'Добрый день, через 5 минут буду у вас.', 'senderId': 'courier'},
  ];

  void sendMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        messages.add({'text': text, 'senderId': 'user'});
      });
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(title: const Text('Чат с курьером')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                if (message['senderId'] == 'courier') {
                  return CourierMessage(text: message['text'] ?? '');
                } else {
                  return UserMessage(text: message['text'] ?? '');
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
          const SizedBox(height: 20),
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
                    margin: const EdgeInsets.only(bottom: 20, top: 10),
                    padding: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(
                          color: const Color.fromRGBO(195, 195, 195, 1)),
                    ),
                    child: TextField(
                      controller: messageController,
                      maxLines: 1,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        hintText: 'Сообщение',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w300),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    sendMessage(messageController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
