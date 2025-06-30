import 'package:flutter/material.dart';
import '../services/voice_service.dart';
import '../services/openai_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userText = '';
  String aiResponse = '';
  bool isListening = false;

  final VoiceService _voiceService = VoiceService();
  final OpenAIService _openAIService = OpenAIService();

  void handleMicTap() async {
    if (!isListening) {
      setState(() => isListening = true);
      String spokenText = await _voiceService.listen();
      setState(() => userText = spokenText);

      if (spokenText.isNotEmpty) {
        String response = await _openAIService.getAIReply(spokenText);
        setState(() => aiResponse = response);
        await _voiceService.speak(response);
      }

      setState(() => isListening = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Friday AI"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("🎙️ You said:\n$userText",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text("🤖 Friday replied:\n$aiResponse",
                style: const TextStyle(fontSize: 16, color: Colors.greenAccent)),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: handleMicTap,
              icon: const Icon(Icons.mic),
              label: Text(isListening ? "Listening..." : "Talk to Friday"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
