import 'dart:convert';

import 'package:http/http.dart' as http;

class ImageAnalyzer {
  static final instance = ImageAnalyzer._();

  static const subscriptionKey = "88246b41bd1b43c0b3965edf2eaef33d";
  ImageAnalyzer._();
  static const requestUrl =
      "https://vision-as2.cognitiveservices.azure.com/vision/v3.2/read/analyze?language=en";

  Future readTextFromImage() async {
    final headers = {
      "Content-Type": "application/json",
      "Ocp-Apim-Subscription-Key": subscriptionKey,
    };
    // Uint8List bytes = await image.readAsBytes();
    final body = jsonEncode({
      "url":
          "https://th.bing.com/th/id/OIP.dsEv4L08e6W-h9I7jVrFvgHaFL?pid=ImgDet&rs=1"
    });
    final response =
        await http.post(Uri.parse(requestUrl), headers: headers, body: body);
    if (response.statusCode == 202) {
      final url = response.headers["operation-location"] as String;
      print("operation id:$url");
      fetchResults(url);
    } else {
      print(response.statusCode);
    }
  }

  Future<void> fetchResults(String operationId) async {
    final headers = {
      "Ocp-Apim-Subscription-Key": subscriptionKey,
    };
    final response = await http.get(Uri.parse(operationId), headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["status"]);
      final lines = data["analyzeResult"]["readResults"][0]['lines'];
      for (var line in lines) {
        print(line["text"]);
      }
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }
}
