import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class VoiceService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();

  /// Convert speech to text
  Future<String> listen() async {
    bool available = await _speech.initialize();
    if (!available) return "Speech not available";

    await _speech.listen(onResult: (_) {});
    await Future.delayed(const Duration(seconds: 5));
    _speech.stop();

    return _speech.lastRecognizedWords;
  }

  /// Speak text aloud
  Future<void> speak(String text) async {
    await _tts.setLanguage("en-US");
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.5);
    await _tts.speak(text);
  }
}
