import 'package:flutter/material.dart';
import 'package:text_translator/pages/speech_to_text.dart';
import 'package:text_translator/pages/text_extraction_page.dart';
import 'package:text_translator/pages/translation_page.dart';

import 'text_to_speech_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Azure Ai Services App'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          buildMethod(
              context, 'Translator', Icons.translate, const TranslationPage()),
          buildMethod(context, 'Text extractor', Icons.wrap_text,
              const TextExtractionPage()),
          buildMethod(context, 'Text to speech', Icons.audio_file,
              const TextToSpeechPage()),
          buildMethod(context, 'Speech to text', Icons.record_voice_over,
              const SpeechToTextPage()),
        ],
      ),
    );
  }

  SizedBox buildMethod(context, text, icon, Widget destination) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => destination));
        },
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}
