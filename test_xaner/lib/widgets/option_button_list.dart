import 'package:flutter/material.dart';
import 'package:test_xaner/screens/barcode_scanner.dart';
import 'package:test_xaner/screens/image_text_scanner_screen.dart';
import 'package:test_xaner/screens/face_detection.dart';
import 'package:test_xaner/screens/image_labeler_screen.dart';
import 'package:image_picker/image_picker.dart';

class ImageOptions extends StatelessWidget {
  ImageOptions({this.imageSource});

  final ImageSource imageSource;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 300.0,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.red[700],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: OptionButtonList(
          imageSource: imageSource,
        ),
      ),
    );
  }
}

class OptionButtonList extends StatelessWidget {
  OptionButtonList({this.imageSource});

  final ImageSource imageSource;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OptionsContainer(
          text: 'Text Recognition',
          iconData: Icons.text_fields,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageTextScanner(
                  imageSource: imageSource,
                ),
              ),
            );
          },
        ),
        OptionsContainer(
          text: 'Barcode Scanner',
          iconData: Icons.line_weight,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BarcodeScanner(
                          imageSource: imageSource,
                        )));
          },
        ),
        OptionsContainer(
          text: 'Face Detection',
          iconData: Icons.face,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FaceDetectionWidget(
                          imageSource: imageSource,
                        )));
          },
        ),
      ],
    );
  }
}

class OptionsContainer extends StatelessWidget {
  OptionsContainer({this.text, this.iconData, this.onTap});

  final String text;
  final IconData iconData;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GestureDetector(
        child: Container(
          height: 60.0,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Icon(
                iconData,
                size: 30.0,
              ),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
