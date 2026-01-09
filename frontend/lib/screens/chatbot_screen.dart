import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final String _sessionId =
    DateTime.now().millisecondsSinceEpoch.toString();

  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  // 🔹 CHANGE ONLY IF BACKEND URL CHANGES
  static const String apiUrl = 'http://localhost:8001/chat';


  // --------------------------------------------
  // Format long AI responses for readability
  // --------------------------------------------
  String formatResponse(String text) {
    return text
        .replaceAll('. ', '.\n\n')
        .replaceAll(':', ':\n')
        .trim();
  }

  // --------------------------------------------
  // Send message to backend
  // --------------------------------------------
  Future<void> _sendMessage() async {
    final userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': userMessage});
      _isLoading = true;
    });

    _controller.clear();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
  'question': userMessage,
  'session_id': _sessionId,
}),

      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botReply = data['answer'] ?? 'No response';

        setState(() {
          _messages.add({
            'role': 'bot',
            'text': formatResponse(botReply),
          });
        });
      } else {
        setState(() {
          _messages.add({
            'role': 'bot',
            'text': '⚠️ Server error (${response.statusCode})',
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'role': 'bot',
          'text': '❌ Error connecting to AI Tutor',
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // --------------------------------------------
  // Chat bubble widget
  // --------------------------------------------
  Widget _chatBubble(String text, bool isUser) {
    final theme = Theme.of(context);
    final maxWidth = MediaQuery.of(context).size.width * 0.7;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser
              ? theme.colorScheme.primary
              : theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(14),
        ),
        child: SelectableText(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : null,
            fontSize: 14.5,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  // --------------------------------------------
  // UI
  // --------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Tutor'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['role'] == 'user';

                return _chatBubble(msg['text']!, isUser);
              },
            ),
          ),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(strokeWidth: 2),
            ),

          // Input bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: const InputDecoration(
                      hintText: 'Ask about machine learning...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
