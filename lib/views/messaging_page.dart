import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
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
  _MessagesAndNotificationsScreenState createState() =>
      _MessagesAndNotificationsScreenState();
}

class _MessagesAndNotificationsScreenState
    extends State<MessagesAndNotificationsScreen> {
  final DatabaseReference _messagesDatabase =
  FirebaseDatabase.instance.ref('messages/accounts');
  final DatabaseReference _notificationsDatabase =
  FirebaseDatabase.instance.ref('notifications');
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  final List<String> _notifications = [];
  final ImagePicker _picker = ImagePicker();
  bool _isExpanded = false;
  bool _isInputVisible = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _loadNotifications();
  }

  Future<void> _loadMessages() async {
    _messagesDatabase.onValue.listen((DatabaseEvent event) {
      final List<Message> messages = [];
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        data.forEach((key, value) {
          final message = Message.fromMap(Map<String, dynamic>.from(value));
          messages.add(message);
        });
      }

      messages.sort(
              (a, b) => DateTime.parse(a.timestamp).compareTo(DateTime.parse(b.timestamp)));

      setState(() {
        _messages.clear();
        _messages.addAll(messages);
      });
    });
  }

  Future<void> _loadNotifications() async {
    _notificationsDatabase.onValue.listen((DatabaseEvent event) {
      final List<String> notifications = [];
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        data.forEach((key, value) {
          final notificationData = Map<String, dynamic>.from(value);
          notifications.add(notificationData['content'] ?? '');
        });
      }

      setState(() {
        _notifications.clear();
        _notifications.addAll(notifications);
      });
    });
  }


  void _sendMessage({String? imageUrl}) {
    if (_controller.text.isNotEmpty || imageUrl != null) {
      final message = Message(
        content: imageUrl ?? _controller.text,
        senderId: 'user',
        timestamp: DateTime.now().toIso8601String(),
        isImage: imageUrl != null,
      );

      _messagesDatabase.push().set(message.toMap());
      _controller.clear();
    }
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}_${pickedFile.name}');

      try {
        final UploadTask uploadTask = storageReference.putFile(file);
        final TaskSnapshot snapshot = await uploadTask;

        String imageUrl = await snapshot.ref.getDownloadURL();

        _sendMessage(imageUrl: imageUrl);
      } catch (e) {
        _showErrorDialog('Image Selection Error', 'Could not select image from gallery. Please try again.');
      }
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
              ..._notifications
                  .map((notification) => MessageBubble(
                content: notification,
                isNotification: true,
              ))
                  .toList(),
              const SizedBox(height: 20),
              const Text(
                'Messages:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                    _isInputVisible = _isExpanded;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Chat',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Icon(
                        _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (_isExpanded)
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    thickness: 8,
                    radius: const Radius.circular(20),
                    child: ListView.builder(
                      reverse: false,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return MessageBubble(
                          content: _messages[index].content,
                          isSender: _messages[index].senderId == 'user',
                          isImage: _messages[index].isImage,
                        );
                      },
                    ),
                  ),
                ),
              if (_isInputVisible)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.grey),
                        onPressed: _pickImageFromGallery,
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
                        onPressed: () => _sendMessage(),
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
  final bool isImage;
  final bool isNotification;

  const MessageBubble({
    Key? key,
    required this.content,
    this.isSender = false,
    this.isImage = false,
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
          color: isNotification
              ? Colors.amber.shade100
              : (isSender ? Colors.lightBlueAccent : Colors.white),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isSender ? const Radius.circular(12) : Radius.zero,
            bottomRight: isSender ? Radius.zero : const Radius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isNotification)
              const Icon(
                Icons.notifications,
                color: Colors.orange,
                size: 25,
              ),
            const SizedBox(width: 8),
            isImage
                ? ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: Image.network(
                content,
                fit: BoxFit.cover,
              ),
            )
                : Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: isSender || isNotification ? Colors.black : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

