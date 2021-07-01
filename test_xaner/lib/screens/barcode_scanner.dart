//import 'dart:html';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:test_xaner/constants.dart';

class BarcodeScanner extends StatefulWidget {
  BarcodeScanner({this.imageSource});

  final ImageSource imageSource;

  @override
  _BarcodeScannerState createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  File _image;
  String barcodeImageValue;

  Future getImage() async {
    print('Capturing Image');
    final image = await ImagePicker().getImage(source: widget.imageSource);

    setState(() {
      _image = File(image.path);
      barcodeImage();
    });
  }

  Future barcodeImage() async {
    // Creating a FirebaseVisionImage
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(_image);
    final BarcodeDetector barcodeDetector =
        FirebaseVision.instance.barcodeDetector();
    final List<Barcode> barcodes =
        await barcodeDetector.detectInImage(visionImage);

    String rawValue;
    for (Barcode barcode in barcodes) {
      rawValue = barcode.rawValue;

      print('\n\n\n\n\n\n\n\n\n');
      print(rawValue);
      barcodeImageValue = rawValue;
    }

    setState(() {
      barcodeImageValue = rawValue;
    });
  }

  @override
  void initState() {
    getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColour,
      body: Stack(children: [
        Container(
          child: _image == null
              ? Center(
                  child: Text(
                  'No image Scanned',
                  style: TextStyle(fontSize: 30.0),
                ))
              : Expanded(
                  child: Image.file(
                    _image,
                    fit: BoxFit.contain,
                  ),
                ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height - 100,
          child: Container(
            color: Colors.red,
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            child: barcodeImageValue == null
                ? Center(child: Text('No Barcode Detected'))
                : Center(child: Text(barcodeImageValue)),
          ),
        )
      ]),
    );
  }
}
