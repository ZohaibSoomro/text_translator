import 'package:flutter/material.dart';

class LanguageDropDown extends StatelessWidget {
  const LanguageDropDown(
      {super.key,
      required this.initialValue,
      required this.onLanguageChanged,
      required this.langList});

  final String initialValue;

  final ValueChanged<String?> onLanguageChanged;

  final Map<String, String> langList;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialValue,
      onChanged: onLanguageChanged,
      items: langList.keys.map((e) {
        return DropdownMenuItem<String>(
          value: e,
          child: Text("${langList[e]}"),
        );
      }).toList(),
    );
  }
}
