import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatApiService {
  static const String _baseUrl =
      'http://127.0.0.1:8000/chat'; // ✅ Desktop URL

  Future<String> sendMessage({
    required String question,
    required String sessionId,
  }) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'question': question,
        'session_id': sessionId,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['answer'] ?? 'No response';
    } else {
      throw Exception('Chatbot API error');
    }
  }
}
