import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:text_translator/widgets/gradient_button.dart';

class TextToSpeechPage extends StatefulWidget {
  const TextToSpeechPage({super.key});

  @override
  State<TextToSpeechPage> createState() => _TextToSpeechPageState();
}

class _TextToSpeechPageState extends State<TextToSpeechPage> {
  bool isLoading = false;

  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text to Speech'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),
              TextField(
                controller: controller,
                onSubmitted: (val) => onTextToSpeech,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'input your text',
                ),
              ),
              const SizedBox(height: 20),
              GradientButton(
                text: 'Generate speech',
                onPressed: onTextToSpeech,
                gradient: LinearGradient(
                  colors: [Colors.pink[100]!, Colors.pink[300]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTextToSpeech() {}
}
