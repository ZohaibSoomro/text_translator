import 'package:flutter/material.dart';
import 'package:text_translator/pages/translation_page.dart';
import 'package:image_picker_android/image_picker_android.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:text_translator/pages/home.dart';

void main() async {
  final ImagePickerPlatform imagePickerImplementation =
      ImagePickerPlatform.instance;
  if (imagePickerImplementation is ImagePickerAndroid) {
    imagePickerImplementation.useAndroidPhotoPicker = true;
  }
  WidgetsFlutterBinding.ensureInitialized();
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
