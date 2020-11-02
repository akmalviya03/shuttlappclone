import 'package:flutter/material.dart';
import 'TextWrapContainer.dart';

class BottomTextLast2Screens extends StatelessWidget {
  const BottomTextLast2Screens({
    @required this.firstToSecond,
    @required this.bottomText,
  });
  final ValueNotifier<double> firstToSecond;
  final String bottomText;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: firstToSecond.value,
      child: TextWrapContainer(bottomText: bottomText),
    );
  }
}