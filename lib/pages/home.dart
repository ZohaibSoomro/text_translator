import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:text_translator/utils/image_analyzer.dart';
import 'package:text_translator/widgets/language_drop_down.dart';

import '../utils/translator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = TextEditingController();
  Translator translator = Translator.instance;
  String translatedText = '';
  bool isLoading = false;

  Map<String, String> languages = {};

  String toLanguage = 'ur';

  @override
  void initState() {
    super.initState();
    loadLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Translator app'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: controller,
                onSubmitted: onTranslate,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'input your text',
                ),
              ),
              const SizedBox(height: 20),
              LanguageDropDown(
                initialValue: toLanguage,
                onLanguageChanged: onLanguageChanged,
                langList: languages,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    onTranslate(controller.text);
                  }
                },
                child: const Text('Translate'),
              ),
              const SizedBox(height: 20),
              Text(
                'translation: $translatedText',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            ImageAnalyzer.instance.readTextFromImage();
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }

  void onTranslate(String value) async {
    setState(() {
      isLoading = true;
    });
    translatedText =
        await Translator.instance.translateText(value, toLanguage: toLanguage);
    setState(() {
      isLoading = false;
    });
  }

  void loadLanguages() async {
    setState(() {
      isLoading = true;
    });
    languages = await Translator.instance.languages();
    setState(() {
      isLoading = false;
    });
  }

  void onLanguageChanged(String? code) {
    setState(() {
      toLanguage = code ?? 'ur';
    });
    debugPrint(toLanguage);
  }
}
