import 'package:ava/models/chat_bubble.dart';
import 'package:ava/models/message.dart';
import 'package:ava/models/text_field.dart';
import 'package:ava/pages/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ChatService _chatService = ChatService();

  final TextEditingController _messagecontroller = TextEditingController();

  void sendMessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      await _chatService.sendMessage(_messagecontroller.text);
      _messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("AVA"),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<List<Message>>(
      stream: _chatService.getMessage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No messages yet.'));
        }
        final messages = snapshot.data!;
        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            return _buildMessageItem(message);
          },
        );
      },
    );
  }

  Widget _buildMessageItem(Message message) {
    final DateFormat formatter = DateFormat('HH:mm');
    final String formattedTime = formatter.format(message.timestamp);

    bool isSentByGpt = message.sender == "Gpt";
    TextAlign textAlign = isSentByGpt ? TextAlign.left : TextAlign.right;

    return ListTile(
      title: Align(
        alignment: !isSentByGpt ? Alignment.centerRight : Alignment.centerLeft,
        child: ChatBubble(
          message: message.message,
          iscurrentuser: !isSentByGpt,
        ),
      ),
      subtitle: Text(
        formattedTime,
        textAlign: textAlign,
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: Mytextfield(
                hint: "Enter a message",
                obscuretext: false,
                controller: _messagecontroller),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: sendMessage, icon: const Icon(Icons.arrow_upward)),
          )
        ],
      ),
    );
  }
}
