import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:test_xaner/constants.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class FaceDetectionWidget extends StatefulWidget {
  FaceDetectionWidget({this.imageSource});

  final ImageSource imageSource;

  @override
  _FaceDetectionWidgetState createState() => _FaceDetectionWidgetState();
}

class _FaceDetectionWidgetState extends State<FaceDetectionWidget> {
  File pickedImage;
  var imageFile;

  List<Rect> rect = List<Rect>();
  bool isFaceDetected = false;

  Future getImage() async {
    final awaitImage = await ImagePicker().getImage(source: widget.imageSource);

    imageFile = await awaitImage.readAsBytes();

    imageFile = await decodeImageFromList(imageFile);

    setState(() {
      imageFile = imageFile;
      pickedImage = File(awaitImage.path);

      getFaceDetection();
    });
  }

  Future getFaceDetection() async {
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);
    final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();

    final List<Face> faces = await faceDetector.processImage(visionImage);

    if (rect.length > 0) {
      rect = List<Rect>();
    }

    for (Face face in faces) {
      rect.add(face.boundingBox);
      final double rotY =
          face.headEulerAngleY; // Head is rotated to the right rotY degrees
      final double rotZ =
          face.headEulerAngleZ; // Head is tilted sideways rotZ degrees
      print('the rotation y is ' + rotY.toStringAsFixed(2));
      print('the rotation z is ' + rotZ.toStringAsFixed(2));
    }
    setState(() {
      isFaceDetected = true;
    });
  }

  // Initializing init state to directly open the camera whenever the
  // instance of the class is called

  @override
  void initState() {
    getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColour,
      body: Container(
        child: pickedImage == null
            ? Center(
                child: Text(
                'No Image Selected',
                style: TextStyle(fontSize: 30.0),
              ))
            : FittedBox(
                child: SizedBox(
                  width: imageFile.width.toDouble(),
                  height: imageFile.height.toDouble(),
                  child: CustomPaint(
                    painter: FacePainter(rect: rect, imageFile: imageFile),
                  ),
                ),
              ),
      ),
    );
  }
}

//Class FacePainter

class FacePainter extends CustomPainter {
  List<Rect> rect;
  var imageFile;

  FacePainter({@required this.rect, @required this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    if (imageFile != null) {
      canvas.drawImage(imageFile, Offset.zero, Paint());
    }

    for (Rect rectangle in rect) {
      canvas.drawRect(
        rectangle,
        Paint()
          ..color = Colors.teal
          ..strokeWidth = 18.0
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
