import 'package:flutter/material.dart';
import 'package:text_translator/pages/home.dart';

void main() {
  runApp(const TextTranslatorApp());
}

class TextTranslatorApp extends StatelessWidget {
  const TextTranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
