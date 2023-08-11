import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class ImageAnalyzer {
  static final instance = ImageAnalyzer._();

  static const subscriptionKey = "88246b41bd1b43c0b3965edf2eaef33d";
  ImageAnalyzer._();
  static const requestUrl =
      "https://vision-as2.cognitiveservices.azure.com/vision/v3.2/read/analyze?language=en";

  Future<List<String>> readTextFromImage({Uint8List? byteData}) async {
    final headers = {
      "Content-Type":
          byteData == null ? "application/json" : "application/octet-stream",
      "Ocp-Apim-Subscription-Key": subscriptionKey,
    };
    final body = byteData ??
        jsonEncode({
          "url":
              "https://th.bing.com/th/id/OIP.dsEv4L08e6W-h9I7jVrFvgHaFL?pid=ImgDet&rs=1"
        });
    final response =
        await http.post(Uri.parse(requestUrl), headers: headers, body: body);
    if (response.statusCode == 202) {
      final url = response.headers["operation-location"] as String;
      print("id: $url");
      return await fetchResults(url);
    } else {
      print(response.headers.entries.last);
      print("code: ${response.statusCode}");
      return [];
    }
  }

  Future<List<String>> fetchResults(String operationId) async {
    final headers = {
      "Ocp-Apim-Subscription-Key": subscriptionKey,
    };
    final response = await http.get(Uri.parse(operationId), headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["status"]);
      final lines = data["analyzeResult"]["readResults"][0]['lines'];
      List<String> linesList = [];
      for (var line in lines) {
        linesList.add(line['text']);
      }
      return linesList;
    } else {
      print("results code: ${response.statusCode}");
      print(response.body);
      return [];
    }
  }
}
