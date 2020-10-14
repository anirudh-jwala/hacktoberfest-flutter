import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_xaner/buttonWidget/main_screen_bottom_button.dart';
import 'dart:io';
import 'package:test_xaner/constants.dart';
import 'package:test_xaner/screens/image_text_scanner_screen.dart';
import 'package:test_xaner/widgets/option_button_list.dart';

// This is the main screen of my app

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainScreenColour,
      appBar: AppBar(
        title: Center(
          child: Text('TestXaner'),
        ),
        elevation: 0.0,
      ),
      body: MainScreenState(),
    );
  }
}

class MainScreenState extends StatefulWidget {
  @override
  _MainScreenStateState createState() => _MainScreenStateState();
}

class _MainScreenStateState extends State<MainScreenState> {
  File _image;

  // This is a function to get the image from the camera

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // using the floating action button
        Padding(
          padding: EdgeInsets.all(20.0),
          child: FloatingActionButton(
              backgroundColor: Colors.red,
              child: Icon(
                Icons.camera_enhance,
                size: 35.0,
                color: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ImageOptions(
                        imageSource: ImageSource.camera,
                      ),
                    ),
                  ),
                );
              }),
        ),
        MainScreenBottomButton(), // This is for the bottom button in the screen
      ],
    );
  }
}

// Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ImageTextScanner(),
//                   ),
//                 );
