# Ollama AI Chat

Ollama AI Chat는 Flutter를 사용하여 개발된 AI 채팅 애플리케이션입니다. Ollama AI 모델을 활용하여 사용자의 질문에 대답하고, 필요한 경우 번역 기능을 제공합니다.

## 주요 기능

- Ollama AI 모델을 사용한 대화형 채팅 인터페이스
- 실시간 메시지 애니메이션 효과
- AI 응답 생성 및 번역 시간 측정
- 모듈화된 구조로 번역 기능의 쉬운 추가/제거

| ![image1](/readme_asset/chat1.gif) | ![image2](/readme_asset/chat2.gif) |
| --- | --- |

## 시작하기

### 필요 조건

- Flutter SDK (버전 3.3.4 이상)
- Dart (버전 3.3.4 이상)
- Ollama AI 서버 (로컬 또는 원격)

### 의존성 패키지
- ollama_dart: ^0.1.2
- http: ^1.2.1

## 환경 설정

### Ollama 설정

1. [Ollama 공식 웹사이트](https://ollama.com)에서 운영체제에 맞는 Ollama를 다운로드하고 설치합니다.

2. 터미널을 열고 다음 명령어로 Ollama 서버를 시작합니다:
ollama serve

3. 원하는 모델을 다운로드합니다. 예를 들어, llama3 모델을 사용하려면:
ollama pull llama3

4. `lib/services/ai_service.dart` 파일에서 `_baseUrl`과 `_model` 변수를 설정합니다:

```dart
static const String _baseUrl = 'http://localhost:11434/api';
static const String _model = 'llama3';  // 또는 사용하려는 모델 이름
```

### Papago API 설정

1. 네이버 클라우드 플랫폼에 가입하고 로그인합니다.
2. AI Services - Papago NMT 서비스를 선택합니다.
3. "Application 등록" 메뉴에서 새 애플리케이션을 생성합니다.
4. 생성된 애플리케이션의 Client ID와 Client Secret을 확인합니다.
5. lib/services/translation_service.dart 파일에서 다음 변수들을 설정합니다:

```dart
static const String _clientId = '여기에_당신의_Client_ID를_입력하세요';
static const String _clientSecret = '여기에_당신의_Client_Secret을_입력하세요';
```


6. Papago API 사용량과 요금에 주의하세요. 무료 사용량을 초과하면 요금이 부과될 수 있습니다.

### 주의사항

- Ollama 서버는 로컬에서 실행되므로 보안에 주의하세요. 공개된 네트워크에서 사용할 경우 적절한 보안 조치를 취해야 합니다.
- Papago API 키는 민감한 정보이므로 공개 저장소에 직접 올리지 마세요. 환경 변수나 별도의 설정 파일을 사용하는 것이 좋습니다.


## 설치

1. 이 저장소를 클론합니다: git clone https://github.com/your-username/ollama-ai-chat.git

2. 프로젝트 디렉토리로 이동합니다: cd ollama-ai-chat

3. 필요한 패키지를 설치합니다: flutter pub get

4. `lib/services/ai_service.dart` 파일에서 Ollama AI 서버 URL을 설정합니다.

5. (선택사항) 번역 기능을 사용하려면 `lib/services/translation_service.dart` 파일에서 네이버 Papago API 키를 설정합니다.

### 실행

다음 명령어로 애플리케이션을 실행합니다: flutter run

## 구조

- `lib/main.dart`: 애플리케이션의 진입점
- `lib/screens/home_screen.dart`: 메인 채팅 화면
- `lib/services/ai_service.dart`: Ollama AI 서비스 로직
- `lib/services/translation_service.dart`: 번역 서비스 로직
- `lib/widgets/`: 채팅 UI 관련 위젯들

## 성능 측정

이 애플리케이션은 AI 응답 생성 시간과 번역 시간을 개별적으로 측정하여 로그로 출력합니다. 이를 통해 각 과정의 성능을 모니터링할 수 있습니다.

## 모델 성능 비교

이 프로젝트에서는 두 가지 AI 모델을 테스트했습니다:

1. **yanolja-eeve-korean-instruct-10.8b**: 한국어로 직접 답변을 생성하는 모델
2. **llama3**: 영어로 답변을 생성한 후 Papago API를 통해 한국어로 번역하는 방식

테스트 결과, 다음과 같은 성능 차이가 관찰되었습니다:

### yanolja-eeve-korean-instruct-10.8b 모델:
```dart
[AIService] AI Generation Time: 636777ms
[HomeScreen] Total Process Time: 636802ms
```

### llama3 모델 (Papago 번역 포함):
```dart
[AIService] AI Generation Time: 90281ms
[AIService] Translation Time: 405ms
[AIService] Total Time: 90686ms
[HomeScreen] Total Process Time: 90688ms
```


이 결과를 바탕으로, llama3 모델과 Papago 번역 API를 조합하여 사용하는 것이 전체적인 응답 시간 면에서 더 빠른 성능을 보여주는 것으로 관찰되었습니다.

하지만 이는 제한된 테스트 결과이며, 실제 사용 환경, 질문의 복잡성, 네트워크 상태 등 다양한 요인에 따라 성능이 달라질 수 있습니다. 따라서 사용자의 구체적인 요구사항과 상황에 따라 적절한 모델을 선택하는 것이 중요합니다.

또한, 번역을 거치지 않고 직접 한국어로 답변을 생성하는 모델의 경우, 문맥 이해도나 답변의 자연스러움 면에서 장점이 있을 수 있으므로, 단순히 속도만으로 모델의 우수성을 판단하기는 어렵습니다.

사용자는 프로젝트의 요구사항, 성능, 답변의 품질 등을 종합적으로 고려하여 적절한 모델을 선택해야 합니다.