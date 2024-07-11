import 'package:flutter/material.dart';
import 'package:ollama_ai_chat/screen/home_screen.dart';

void main() {
  runApp(const OllamaAiChat());
}

class OllamaAiChat extends StatelessWidget {
  const OllamaAiChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ollama AI Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

