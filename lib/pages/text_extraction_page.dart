import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:text_translator/utils/image_analyzer.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

import '../widgets/gradient_button.dart';

class TextExtractionPage extends StatefulWidget {
  const TextExtractionPage({super.key});

  @override
  State<TextExtractionPage> createState() => _TextExtractionPageState();
}

class _TextExtractionPageState extends State<TextExtractionPage> {
  final ImagePickerPlatform _picker = ImagePickerPlatform.instance;
  bool isLoading = false;

  XFile? image;

  List<String> linesRead = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text Extractor'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),
              if (image != null)
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.55,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(File(image!.path)), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              const SizedBox(height: 20),
              GradientButton(
                text: 'Upload image',
                onPressed: onUploadImage,
                gradient: LinearGradient(
                  colors: [Colors.pink[100]!, Colors.pink[300]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: linesRead.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () => onLineTapped(index),
                      title: Text(linesRead[index]),
                      textColor: Colors.white,
                      tileColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      trailing: IconButton(
                          onPressed: () => onLineTapped(index),
                          icon: const Icon(
                            Icons.arrow_right_alt,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onUploadImage() async {
    try {
      image = await _picker.getImageFromSource(source: ImageSource.gallery);
      if (image != null) {
        // final bytes = await rootBundle.load("assets/image.png");
        final bytes = await image!.readAsBytes();
        setState(() {
          isLoading = true;
        });
        linesRead =
            await ImageAnalyzer.instance.readTextFromImage(byteData: bytes);
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("error: ${e.toString()}");
    }
  }

  void onLineTapped(int index) {}
}
