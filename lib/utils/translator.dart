import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Translator {
  static final instance = Translator._();

  Translator._();

  Future<Map<String, String?>> translateText(String text,
      {String toLanguage = 'ur'}) async {
    final apiUrl =
        "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&from=en&to=$toLanguage&toScript=Latn";
    final headers = {
      "Ocp-Apim-Subscription-Key": "ec13c379de544938a39fe15f65f51cf8",
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
      final translatedScript = jsonDecode(response.body)[0]['translations'][0]
          ['transliteration']?['text'];
      return {translatedText: translatedScript};
    } else {
      debugPrint(response.statusCode.toString());
      debugPrint(response.headers.entries.last.toString());
    }
    return {"error": "some error occured!"};
  }

  Future<Map<String, String>> languages() async {
    const apiUrl =
        "https://api.cognitive.microsofttranslator.com/languages?api-version=3.0&scope=translation,transliteration";
    Map<String, String> langMap = {};
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['translation'] as Map;
      for (var code in data.keys) {
        langMap[code] = data[code]['name'];
      }
    } else {
      debugPrint("code: ${response.statusCode.toString()}");
    }
    return langMap;
  }
}
