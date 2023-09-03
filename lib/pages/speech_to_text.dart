import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_translator/widgets/gradient_button.dart';

class SpeechToTextPage extends StatefulWidget {
  const SpeechToTextPage({super.key});

  @override
  State<SpeechToTextPage> createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  bool isLoading = false;

  String text = "";
  final controller = TextEditingController();
  SpeechToText speech = SpeechToText();

  bool speechEnabled = false;

  bool isRecording = false;

  void copyToClipBoard() {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Text copied to clipboard'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initSpeech();
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
          title: const Text('Speech to Text'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableText(
                    text,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.width * .15,
                    child: FilledButton(
                        onPressed: isRecording ? null : copyToClipBoard,
                        child: const Icon(Icons.copy)),
                  )
                ],
              ),
              const SizedBox(height: 30),
              GradientButton(
                text: isRecording ? 'stop' : 'record speech',
                onPressed: isRecording ? stop : onSpeechToText,
                gradient: LinearGradient(
                  colors: [Colors.red[100]!, Colors.red],
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

  void stop() {
    // some time later...
    speech.stop();
    setState(() {
      isRecording = false;
    });
  }

  void onSpeechToText() async {
    setState(() {
      isRecording = true;
    });
    if (!speechEnabled) await initSpeech();
    if (speechEnabled) {
      speech.listen(onResult: (val) {
        print("result: ${val.recognizedWords}");
        text = val.recognizedWords;
        if (mounted) setState(() {});
      });
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  Future initSpeech() async {
    bool available = await speech.initialize();
    setState(() {
      speechEnabled = available;
    });
  }
}
