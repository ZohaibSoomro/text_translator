import 'package:flutter/material.dart';

class ListDropDown extends StatelessWidget {
  const ListDropDown(
      {super.key,
      required this.initialValue,
      required this.onLanguageChanged,
      required this.entriesMap,
      this.isSameKeysAndValues = false});

  final String initialValue;
  final bool isSameKeysAndValues;

  final ValueChanged<String?> onLanguageChanged;

  final Map<String, String> entriesMap;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialValue,
      onChanged: onLanguageChanged,
      items: entriesMap.keys.map((e) {
        return DropdownMenuItem<String>(
          value: isSameKeysAndValues ? entriesMap[e] : e,
          child: Text("${entriesMap[e]}"),
        );
      }).toList(),
    );
  }
}
