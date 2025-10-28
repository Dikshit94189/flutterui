import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class DrawerPage1 extends StatefulWidget {
  const DrawerPage1({super.key});

  @override
  State<DrawerPage1> createState() => _DrawerPage1State();
}

class _DrawerPage1State extends State<DrawerPage1> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add({'text': text, 'isUser': true});
    });

    _controller.clear();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add({
          'text': _generateBotReply(text),
          'isUser': false,
        });
      });
    });
  }

  String _generateBotReply(String userText) {
    // Simple fake AI reply logic
    if (userText.toLowerCase().contains('hello')) {
      return "Hey there! 👋 How can I help you today?";
    } else if (userText.toLowerCase().contains('name')) {
      return "I’m your Flutter AI assistant 🤖";
    } else if (userText.toLowerCase().contains('weather')) {
      return "It looks sunny ☀️ — perfect for some Flutter coding!";
    } else {
      return "That's interesting! Tell me more 😄";
    }
  }

  Widget _buildMessageBubble(Map<String, dynamic> msg) {
    bool isUser = msg['isUser'];
    return ChatBubble(
      clipper: ChatBubbleClipper1(
        type: isUser
            ? BubbleType.sendBubble
            : BubbleType.receiverBubble,
      ),
      alignment: isUser ? Alignment.topRight : Alignment.topLeft,
      margin: const EdgeInsets.symmetric(vertical: 4),
      backGroundColor: isUser ? Colors.teal : Colors.grey.shade300,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 250),
        child: Text(
          msg['text'],
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Chat UI 💬"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(messages[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () => _sendMessage(_controller.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}