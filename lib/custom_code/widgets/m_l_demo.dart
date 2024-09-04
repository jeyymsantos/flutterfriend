// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'dart:io';

class MLDemo extends StatefulWidget {
  const MLDemo({
    super.key,
    this.width,
    this.height,
    required this.title,
  });

  final double? width;
  final double? height;
  final String title;

  @override
  State<MLDemo> createState() => _MLDemoState();
}

class _MLDemoState extends State<MLDemo> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;
  var _recognitions;
  var v = "";

  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {});
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
        model:
            "https://firebasestorage.googleapis.com/v0/b/flutter-friend-zfkkka.appspot.com/o/model_unquant.tflite?alt=media&token=313ded43-874f-4851-a1c3-36652ced35b5",
        labels:
            "https://firebasestorage.googleapis.com/v0/b/flutter-friend-zfkkka.appspot.com/o/labels.txt?alt=media&token=ba6f126d-2323-4c89-811f-88e050e1291e");
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        file = File(image!.path);
      });

      detectImage(file!);
    } catch (e) {
      print('Error picking image');
    }
  }

  Future<void> _pickCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
        file = File(image!.path);
      });

      detectImage(file!);
    } catch (e) {
      print("Error capturing image");
    }
  }

  Future detectImage(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _recognitions = recognitions;

      String displayText = '';

      for (var recognition in _recognitions) {
        String label = recognition['label'];
        label = label.substring(2);
        double confidence = recognition['confidence'];

        displayText +=
            'The picture is under the $label category with ${(confidence * 100).toStringAsFixed(2)}% confidence level.';

        break;
      }

      v = displayText;
      // v = recognitions.toString();
    });

    print("///////////////////////////////////////////");
    print(_recognitions);
    print("///////////////////////////////////////////");
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laptop or Phone Detector"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null)
              Image.file(
                File(_image!.path),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              )
            else
              Text("No image selected"),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImage,
              // child: Text("Select Image from Gallery"),
              icon: const Icon(
                Icons.photo_library,
                color: Colors.white,
              ),
              label: const Text(
                "Select Image from Gallery",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  textStyle: const TextStyle(
                    fontSize: 16,
                  )),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _pickCamera,
              // child: Text("Select Image from Gallery"),
              icon: const Icon(
                Icons.camera,
                color: Colors.white,
              ),
              label: const Text(
                "Capture from Camera",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 55, vertical: 12),
                  textStyle: const TextStyle(
                    fontSize: 16,
                  )),
            ),
            const SizedBox(height: 10),
            Text(v)
          ],
        ),
      ),
    );
  }
}
