import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  Future<String> getResponse(String prompt) async {
    String apikey = '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';
    try {
      if (prompt.isNotEmpty) {
        var response = await http.post(
            Uri.parse("https://api.openai.com/v1/chat/completions"),
            headers: {
              "Authorization": "Bearer $apikey",
              "Content-Type": "application/json"
            },
            body: jsonEncode({
              "model": "gpt-3.5-turbo",
              "messages": [
                {"role": "user", "content": prompt}
              ]
            }));
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          return json["choices"][0]["message"]["content"].toString().trimLeft();
        } else {
          return "Error: ${response.statusCode}";
        }
      } else {
        return "Error: Prompt is empty";
      }
    } on Exception catch (e) {
      return "Error: $e";
    }
  }
}
