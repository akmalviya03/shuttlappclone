import 'package:flutter/material.dart';
import 'customOpacityContainer.dart';


class IndicatorStack extends StatelessWidget {
  IndicatorStack(
      {@required this.firstContainerOpacity,
        @required this.secondContainerOpacity});
  final double firstContainerOpacity;
  final double secondContainerOpacity;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CustomOpacityContainer(
        opacityValue: firstContainerOpacity,
      ),
      CustomOpacityContainer(
        opacityValue: secondContainerOpacity,
      ),
    ]);
  }
}