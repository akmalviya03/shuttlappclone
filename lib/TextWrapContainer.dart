import 'package:flutter/material.dart';

import 'constants.dart';

class TextWrapContainer extends StatelessWidget {
  const TextWrapContainer({
    @required this.bottomText,
  });
  final String bottomText;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Text(
        bottomText,
        style: textWeight400,
        textAlign: TextAlign.center,
      ),
    );
  }
}