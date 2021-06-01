import 'package:flutter/material.dart';
import 'package:troveapp/components/theme/sizes.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color color;

  SmallText(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: textbodysizesm),
    );
  }
}
