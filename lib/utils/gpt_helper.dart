// import 'dart:convert';

// import 'package:http/http.dart';

// class GptHelper {
//   static const apiKey = "4ba27be9b3e04cdaa3845cfc2f97c7d3";
//   static const apiUrl = "https://api.bing.microsoft.com/v7.0/search/$apiKey?";
//   static final instance = GptHelper._();
//   GptHelper._();

//   Future replyToChat(String input) async {
//     final header = {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $apiKey",
//     };

//     final body = jsonEncode({
//       "model": "text-davinci-003",
//       "messages": [
//         {"role": "system", "content": input}
//       ],
//     });
//     final response = await post(Uri.parse(apiUrl), headers: header, body: body);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final result = data['choices'][0]['message']['content'];
//       print("Result: $result");
//     } else {
//       print("Code: ${response.statusCode}");
//       print("Code: ${response.body}");
//     }
//   }
// }
