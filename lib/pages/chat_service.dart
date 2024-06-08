import 'package:ava/models/message.dart';
import 'package:ava/pages/gpt.dart';

class ChatService {
  final OpenAIService gpt = OpenAIService();

  List<Message> messages = [
    // Message(sender: "Abhinav", message: "message1", timestamp: DateTime.now())
  ];

  Future<void> sendMessage(String message) async {
    Message newMessage =
        Message(sender: "Abhinav", message: message, timestamp: DateTime.now());
    messages.add(newMessage);

    String response = await gpt.getResponse(message);
    Message responseMsg =
        Message(sender: "Gpt", message: response, timestamp: DateTime.now());
    messages.add(responseMsg);
  }

  Stream<List<Message>> getMessage() {
    // Using Stream.periodic to simulate real-time updates
    return Stream<List<Message>>.periodic(
      Duration(seconds: 1),
      (_) => messages,
    ).asBroadcastStream();
  }
}
