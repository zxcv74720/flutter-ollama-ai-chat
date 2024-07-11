import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  static const String _translationApiUrl = 'https://naveropenapi.apigw.ntruss.com/nmt/v1/translation';
  static const String _clientId = '여기에_당신의_Client_ID를_입력하세요';
  static const String _clientSecret = '여기에_당신의_Client_Secret을_입력하세요';

  Future<String> translateToKorean(String text) async {
    final response = await http.post(
      Uri.parse(_translationApiUrl),
      headers: {
        'X-NCP-APIGW-API-KEY-ID': _clientId,
        'X-NCP-APIGW-API-KEY': _clientSecret,
      },
      body: {
        'source': 'en',
        'target': 'ko',
        'text': text,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['message']['result']['translatedText'];
    } else {
      throw Exception('Failed to translate text');
    }
  }
}