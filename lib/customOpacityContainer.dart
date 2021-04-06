import 'package:flutter/material.dart';

class CustomOpacityContainer extends StatelessWidget {
  const CustomOpacityContainer({@required this.opacityValue});
  final double opacityValue;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Opacity(
        opacity: opacityValue,
        child: Container(
          height: 15,
          width: 15,
          color: Colors.cyan,
        ),
      ),
    );
  }
}