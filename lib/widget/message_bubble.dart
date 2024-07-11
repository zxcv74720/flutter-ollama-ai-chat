import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  final bool isUser;
  final String message;

  const MessageBubble({
    super.key,
    required this.isUser,
    required this.message,
  });

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _characterCount;
  bool _isAnimationComplete = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: widget.message.length * 50),
      vsync: this,
    );
    _characterCount = StepTween(begin: 0, end: widget.message.length)
        .animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isAnimationComplete = true;
          });
        }
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: widget.isUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: _isAnimationComplete
            ? Text(
          widget.message,
          style: TextStyle(color: widget.isUser ? Colors.white : Colors.black),
        )
            : AnimatedBuilder(
          animation: _characterCount,
          builder: (context, child) {
            String text = widget.message.substring(0, _characterCount.value);
            return Text(
              text,
              style: TextStyle(color: widget.isUser ? Colors.white : Colors.black),
            );
          },
        ),
      ),
    );
  }
}

