class Message {
  final String sender;
  final String message;
  final DateTime timestamp;

  Message({
    required this.sender,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap(Function(dynamic doc) param0) {
    return {
      "sender": sender,
      "message": message,
      "timestamp": timestamp,
    };
  }
}
