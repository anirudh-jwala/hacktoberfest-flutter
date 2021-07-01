import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

class ImageLabelerScreen extends StatefulWidget {
  @override
  _ImageLabelerScreenState createState() => _ImageLabelerScreenState();
}

class _ImageLabelerScreenState extends State<ImageLabelerScreen> {
  File pickedImage;
  bool imageLoaded;
  String text = '';

  Future pickImage() async {
    print('\n\n\n\n\n GETTING IMAGE LABEL');
    var awaitImage = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      pickedImage = File(awaitImage.path);
      imageLoaded = true;
    });

    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);

    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();

    final List<ImageLabel> Labels = await labeler.processImage(visionImage);
    for (ImageLabel label in Labels) {
      final double confidence = label.confidence;
      setState(() {
        text = "$text $label.text   $confidence.toStringAsFixed(2) \n";

        print(text);
      });
    }

    labeler.close();
  }

  @override
  void initState() {
    pickImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white10,
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child:
                      pickedImage == null ? Text('') : Image.file(pickedImage),
                ),
              ),
            ],
          ),
        ));
  }
}
