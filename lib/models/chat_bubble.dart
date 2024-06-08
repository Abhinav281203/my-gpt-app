import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool iscurrentuser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.iscurrentuser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: iscurrentuser ? Colors.green : Colors.grey,
          borderRadius: BorderRadius.circular(19)),
      padding: const EdgeInsets.all(15),
      child: Text(message),
    );
  }
}
