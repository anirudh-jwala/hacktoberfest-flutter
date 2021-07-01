import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:test_xaner/constants.dart';

class ImageTextScanner extends StatefulWidget {
  ImageTextScanner({this.imageSource});

  final ImageSource imageSource;

  @override
  _ImageTextScannerState createState() => _ImageTextScannerState();
}

class _ImageTextScannerState extends State<ImageTextScanner> {
  File _image;
  String imageText = '';
  List<String> imageTextList = [];
  String finalText = '';

  Future getImage() async {
    print('Capturing Image');
    final image = await ImagePicker().getImage(source: widget.imageSource);

    setState(() {
      _image = File(image.path);
      textImage();
    });
  }

  Future textImage() async {
    FirebaseVisionImage imageVision = FirebaseVisionImage.fromFile(_image);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(imageVision);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        if (line.text != '') {
          imageTextList.add(line.text);
          finalText += line.text;
          finalText += '\n';
        }
        for (TextElement word in line.elements) {
          if (word.text != null) {
            imageText = imageText + word.text;
            imageText = imageText + ' ';
          }
        }
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    getImage();

    if (_image != null) {
      print('Image is been captured');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kAppBackgroundColour,
        body: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * (0.6),
            width: MediaQuery.of(context).size.width,
            child: _image == null
                ? Center(
                    child: Text(
                      'No image was selected',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  )
                : Image.file(
                    _image,
                    fit: BoxFit.cover,
                  ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              color: kAppBackgroundColour,
              height: MediaQuery.of(context).size.height * (0.35),
              width: MediaQuery.of(context).size.width,
              child: SelectableText(
                finalText,
                textAlign: TextAlign.center,
                dragStartBehavior: DragStartBehavior.start,
                showCursor: true,
                cursorWidth: 5.0,
                cursorColor: Colors.red,
              ),
            ),
          )
        ]),
      ),
    );
  }
}

//Expanded(
//
//),

//
//child: ListView.builder(
//itemBuilder: (context, index) {
//final task = imageTextList[index];
//return Container(
//padding: EdgeInsets.all(5.0),
//child: SelectableText(
//task,
//showCursor: true,
//cursorWidth: 5.0,
//cursorColor: Colors.red,
//),
//);
//},
//itemCount: imageTextList.length,
//),
