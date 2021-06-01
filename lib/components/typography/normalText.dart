import 'package:flutter/material.dart';
import 'package:troveapp/components/theme/sizes.dart';

class NormalText extends StatelessWidget {
  final String text;
  final Color color;

  NormalText(this.text, this.color);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: textbodysize),
    );
  }
}
