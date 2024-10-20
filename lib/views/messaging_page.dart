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
  final DatabaseReference _database = FirebaseDatabase.instance.ref('messages'); // Reference to Firebase
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  // Fetch messages from Firebase
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

  // Send message to Firebase
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final message = Message(
        content: _controller.text,
        senderId: 'user', // Replace 'user' with actual sender ID if needed
        timestamp: DateTime.now().toIso8601String(),
      );

      _database.child('user').push().set(message.toMap()); // Push new message to the database
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
                      isSender: _messages[index].senderId == 'user', // Adjust sender check as needed
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
                        // Implement camera action
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

  const MessageBubble({
    Key? key,
    required this.content,
    required this.isSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSender ? Colors.lightBlueAccent : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isSender ? const Radius.circular(12) : Radius.zero,
            bottomRight: isSender ? Radius.zero : const Radius.circular(12),
          ),
        ),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}