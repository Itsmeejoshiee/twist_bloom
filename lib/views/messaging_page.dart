import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../widgets/gradient_background.dart';
import '../models/message_model.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MessagesAndNotificationsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MessagesAndNotificationsScreen extends StatefulWidget {
  const MessagesAndNotificationsScreen({super.key});

  @override
  _MessagesAndNotificationsScreenState createState() => _MessagesAndNotificationsScreenState();
}

class _MessagesAndNotificationsScreenState extends State<MessagesAndNotificationsScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref('messages/accounts');
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    _database.onValue.listen((DatabaseEvent event) {
      final List<Message> messages = [];
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        data.forEach((key, value) {
          final message = Message.fromMap(Map<String, dynamic>.from(value));
          messages.add(message);
        });
      }

      setState(() {
        _messages.clear();
        _messages.addAll(messages);
      });
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final message = Message(
        content: _controller.text,
        senderId: 'user',
        timestamp: DateTime.now().toIso8601String(),
      );

      _database.push().set(message.toMap());
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Row(
                children: [
                  SizedBox(width: 8),
                  Text(
                    'Messages & Notification',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Notifications:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const MessageBubble(content: 'Lorem ipsum dolor amet, consectetur', isNotification: true),
              const MessageBubble(content: 'Lorem ipsum dolor amet, consectetur', isNotification: true),
              const SizedBox(height: 20),
              const Text(
                'Messages:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return MessageBubble(
                      content: _messages[index].content,
                      isSender: _messages[index].senderId == 'user',
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.grey),
                      onPressed: () {
                        // Dito pang camera
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Message...',
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.pink),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String content;
  final bool isSender;
  final bool isNotification;

  const MessageBubble({
    Key? key,
    required this.content,
    this.isSender = false,
    this.isNotification = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isNotification ? Colors.grey.shade200 : (isSender ? Colors.lightBlueAccent : Colors.white),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isSender ? const Radius.circular(12) : Radius.zero,
            bottomRight: isSender ? Radius.zero : const Radius.circular(12),
          ),
        ),
        child: Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: isSender || isNotification ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
