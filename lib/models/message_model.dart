class Message {
  String content;
  String senderId; // Optional: You can store the sender's ID
  String timestamp; // Optional: Store the timestamp of the message

  Message({required this.content, required this.senderId, required this.timestamp});

  // Convert a Message object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'senderId': senderId,
      'timestamp': timestamp,
    };
  }

  // Convert a Map object into a Message object
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      content: map['content'] ?? '',
      senderId: map['senderId'] ?? '',
      timestamp: map['timestamp'] ?? '',
    );
  }
}
