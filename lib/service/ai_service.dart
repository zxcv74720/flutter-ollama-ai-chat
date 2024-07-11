import 'dart:developer';
import 'package:ollama_ai_chat/service/translation_service.dart';
import 'package:ollama_dart/ollama_dart.dart';

class AIService {
  static const String _baseUrl = 'http://localhost:11434/api';
  static const String _model = 'llama3';

  final OllamaClient _client = OllamaClient(baseUrl: _baseUrl);
  final TranslationService _translationService = TranslationService();

  // 번역 O
  Future<String> generateResponse(String prompt) async {
    final stopwatch = Stopwatch()..start();

    final aiResponse = await _generateAIResponse(prompt);
    final aiGenerationTime = stopwatch.elapsedMilliseconds;

    log('AI Generation Time: ${aiGenerationTime}ms', name: 'AIService');

    stopwatch.reset();
    final translatedResponse = await _translationService.translateToKorean(aiResponse);
    final translationTime = stopwatch.elapsedMilliseconds;

    log('Translation Time: ${translationTime}ms', name: 'AIService');
    log('Total Time: ${aiGenerationTime + translationTime}ms', name: 'AIService');

    return translatedResponse;
  }

  // 번역 X
  // Future<String> generateResponse(String prompt) async {
  //   final stopwatch = Stopwatch()..start();
  //
  //   final aiResponse = await _generateAIResponse(prompt);
  //   final aiGenerationTime = stopwatch.elapsedMilliseconds;
  //
  //   log('AI Generation Time: ${aiGenerationTime}ms', name: 'AIService');
  //
  //   return aiResponse;
  // }

  Future<String> _generateAIResponse(String prompt) async {
    final stream = _client.generateCompletionStream(
      request: GenerateCompletionRequest(
        model: _model,
        prompt: prompt,
      ),
    );

    String fullResponse = '';
    await for (final chunk in stream) {
      fullResponse += chunk.response ?? '';
    }

    return fullResponse;
  }
}

