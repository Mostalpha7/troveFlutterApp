import 'package:flutter/material.dart';
import 'package:troveapp/components/theme/sizes.dart';

class AppIconButton extends StatelessWidget {
  final Color backGroundColor;
  final Color color;
  final IconData icon;
  final Function onTap;

  AppIconButton({this.icon, this.color, this.backGroundColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
