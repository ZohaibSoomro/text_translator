import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:text_translator/widgets/list_drop_down.dart';

import '../utils/translator.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final controller = TextEditingController();
  Translator translator = Translator.instance;
  String translatedText = '';
  bool isLoading = false;

  Map<String, String> languages = {};

  String toLanguage = 'ur';

  String translatedScript = "";

  @override
  void initState() {
    super.initState();
    loadLanguages();
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
          title: const Text('Translator'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextField(
              controller: controller,
              onSubmitted: onTranslate,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'input your text',
              ),
            ),
            const SizedBox(height: 20),
            ListDropDown(
              initialValue: toLanguage,
              onLanguageChanged: onLanguageChanged,
              entriesMap: languages,
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
            const SizedBox(height: 10),
            Text(
              'transliteration: $translatedScript',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void onTranslate(String value) async {
    setState(() {
      isLoading = true;
    });
    final translation =
        await Translator.instance.translateText(value, toLanguage: toLanguage);
    translatedText = translation.keys.first;
    translatedScript = translation.values.first ?? 'error';

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
