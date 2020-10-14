import 'package:flutter/material.dart';
import 'constants.dart';

class BottomButton extends StatelessWidget {
  final String buttonTitle;
  final Function onTap;
  BottomButton({@required this.buttonTitle, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              buttonTitle,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        color: kBottomContainerColor,
        margin: EdgeInsets.only(top:10.0),
        width: double.infinity,
        height: kBottomContainerHeight,

      ),
    );
  }
}