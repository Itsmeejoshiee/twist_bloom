import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

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

class MessagesAndNotificationsScreen extends StatelessWidget {
  const MessagesAndNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
        child:Scaffold(
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
              // Example Notification bubbles
              const MessageBubble(content: 'Lorem ipsum dolor amet, consectetur', isNotification: true),
              const MessageBubble(content: 'Lorem ipsum dolor amet, consectetur', isNotification: true),
              const SizedBox(height: 20),
              const Text(
                'Messages:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Messages section with profile avatars
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MessageScreen()),
                  );
                },
                child: const MessageBubble(
                  content: 'Lorem ipsum dolor amet, consectetur',
                  hasAvatar: true,
                  avatarPath: 'assets/images/avatar1.png',
                  title: 'Twist & Bloom',
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
  final bool hasAvatar;
  final String? avatarPath;
  final String? title;
  final bool isNotification;

  const MessageBubble({
    super.key,
    required this.content,
    this.hasAvatar = false,
    this.avatarPath,
    this.title,
    this.isNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isNotification ? Colors.grey.shade200 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (hasAvatar && avatarPath != null) ...[
            CircleAvatar(
              backgroundImage: AssetImage(avatarPath!),
              radius: 24,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Text(content, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF92B2),
        elevation: 0,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar1.png'), // Avatar image
            ),
            SizedBox(width: 12),
            Text(
              'Twist & Bloom',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              reverse: true, // Show new messages at the bottom
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  content: _messages[_messages.length - 1 - index],
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
    );
  }
}
