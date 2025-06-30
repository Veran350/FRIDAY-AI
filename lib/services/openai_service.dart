import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/config.dart';

class OpenAIService {
  Future<String> getAIReply(String prompt) async {
    const url = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $openAIApiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
            "content":
                assistantInstructions // from config.dart
          },
          {
            "role": "user",
            "content": prompt
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final message = data['choices'][0]['message']['content'];
      return message.trim();
    } else {
      return "Sorry, I couldn’t connect to my AI brain.";
    }
  }
}
