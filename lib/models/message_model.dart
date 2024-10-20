class Message {
  final String content;
  final String senderId;
  final String timestamp;
  final bool isImage;

  Message({
    required this.content,
    required this.senderId,
    required this.timestamp,
    this.isImage = false,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      content: map['content'],
      senderId: map['senderId'],
      timestamp: map['timestamp'],
      isImage: map['isImage'] ?? false,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'senderId': senderId,
      'timestamp': timestamp,
      'isImage': isImage,
    };
  }
}
