import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebsocketTest extends StatefulWidget {
  const WebsocketTest({super.key});

  @override
  State<WebsocketTest> createState() => _WebsocketTestState();
}

class _WebsocketTestState extends State<WebsocketTest> {
  late WebSocketChannel channel;

  Map<String, dynamic> data = {
    "id": "7422f31a-6343-4b62-84c2-1d720ee4157f",
    "status": "processing"
  };

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(
      Uri.parse('ws://echo.websocket.org'),
    );

    channel.stream.listen(
      (message) {
        // print('Received: $message');
      },
      onDone: () {
        // print('WebSocket closed');
      },
      onError: (error) {
        // print('Error: $error');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          onPressed: _sendMessage,
          tooltip: 'Send message',
          child: const Icon(Icons.send),
        ),
      ),
    );
  }

  void _sendMessage() {
    // print('Sending message: ${json.encode(data)}');
    channel.sink.add(json.encode(data));
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }
}
