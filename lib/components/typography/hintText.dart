import 'package:flutter/material.dart';
import 'package:troveapp/components/theme/sizes.dart';

class HintText extends StatelessWidget {
  final Color color;
  final String text;

  HintText(this.color, this.text);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Text(
      text,
      style: TextStyle(fontSize: textbodysizesm, color: color),
    );
  }
}
