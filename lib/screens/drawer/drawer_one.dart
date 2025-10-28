import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';



// CLASS WITH SIMPLE CHAT BUBBLE
/*class DrawerPage1 extends StatefulWidget {
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
}*/


/* CLASS WITH ANIMATED CHAT BUBBLE*/

class DrawerPage1 extends StatefulWidget {
  const DrawerPage1({super.key});

  @override
  State<DrawerPage1> createState() => _DrawerPage1State();
}

class _DrawerPage1State extends State<DrawerPage1>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [];
  final ScrollController _scrollController = ScrollController();

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add({'text': text, 'isUser': true});
    });

    _scrollToBottom();

    _controller.clear();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add({
          'text': _generateBotReply(text),
          'isUser': false,
        });
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    });
  }

  String _generateBotReply(String userText) {
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

  Widget _buildMessageBubble(Map<String, dynamic> msg, int index) {
    bool isUser = msg['isUser'];

    // Use AnimatedOpacity + AnimatedContainer for fade-in + smooth scale
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ChatBubble(
        clipper: ChatBubbleClipper2(
          type:
          isUser ? BubbleType.sendBubble : BubbleType.receiverBubble,
        ),
        alignment: isUser ? Alignment.topRight : Alignment.topLeft,
        backGroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(maxWidth: 260),
          decoration: BoxDecoration(
            gradient: isUser
                ? const LinearGradient(
              colors: [Color(0xFF00BFA5), Color(0xFF1DE9B6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : const LinearGradient(
              colors: [Color(0xFFE0E0E0), Color(0xFFBDBDBD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 600),
            child: Text(
              msg['text'],
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 16,
                height: 1.3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Chat 💬"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(messages[index], index);
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
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 25,
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