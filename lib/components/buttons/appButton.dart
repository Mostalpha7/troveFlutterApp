import 'package:flutter/material.dart';
import 'package:troveapp/components/theme/sizes.dart';

class AppButton extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final String text;
  final Function onTap;
  AppButton({
    @required this.color,
    @required this.backgroundColor,
    @required this.text,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth,
        height: 49,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            text,
            style: TextStyle(color: color),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
