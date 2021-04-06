import 'package:flutter/material.dart';
import 'TextWrapContainer.dart';
import 'constants.dart';

class BottomText extends StatelessWidget {
  const BottomText({
    @required this.firstToSecond,
    @required this.bottomText,
  });
  final double firstToSecond;
  final String bottomText;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: firstToSecond,
      child: Container(
        color: Colors.white,
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Text(
          bottomText,
          style: ktextWeight400,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}