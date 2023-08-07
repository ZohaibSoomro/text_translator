import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Translator {
  static final instance = Translator._();

  Translator._();

  Future<String> translateText(String text, {String toLanguage = 'ur'}) async {
    final apiUrl =
        "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&from=en&to=$toLanguage";
    final headers = {
      "Ocp-Apim-Subscription-Key": "d4e7b4d7fb64481ebce4524ba5b6ef8a",
      "Ocp-Apim-Subscription-Region": "centralindia",
      "Content-Type": "application/json; charset=UTF-8"
    };
    final body = jsonEncode([
      {"Text": text}
    ]);

    final response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: body);
    if (response.statusCode == 200) {
      final translatedText =
          jsonDecode(response.body)[0]['translations'][0]['text'];
      return translatedText;
    } else {
      debugPrint(response.statusCode.toString());
    }
    return "some error occured!";
  }

  Future<Map<String, String>> languages() async {
    const apiUrl =
        "https://api.cognitive.microsofttranslator.com/languages?api-version=3.0&scope=translation";
    Map<String, String> langMap = {};
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['translation'] as Map;
      for (var code in data.keys) {
        langMap[code] = data[code]['name'];
      }
    } else {
      debugPrint(response.statusCode.toString());
    }
    return langMap;
  }
}
