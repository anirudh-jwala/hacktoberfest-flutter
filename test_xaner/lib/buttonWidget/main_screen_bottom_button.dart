import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_xaner/widgets/option_button_list.dart';

class MainScreenBottomButton extends StatefulWidget {
  @override
  _MainScreenBottomButtonState createState() => _MainScreenBottomButtonState();
}

class _MainScreenBottomButtonState extends State<MainScreenBottomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: MediaQuery.of(context).size.height / 10.0,
        width: double.infinity,
        color: Colors.red,
        child: Center(
          child: Text('Load From Device'),
        ),
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: ImageOptions(
                      imageSource: ImageSource.gallery,
                    ),
                  ),
                ));
      },
    );
  }
}
