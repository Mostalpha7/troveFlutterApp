import 'package:flutter/material.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/headerThree.dart';
import 'package:troveapp/components/typography/hintText.dart';

class InfoCard2 extends StatelessWidget {
  final Color color;
  final String info;
  final String details;

  InfoCard2(this.color, this.info, this.details);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Container(
      height: 0.1 * screenHeight,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderThree(info, mainColor),
              SizedBox(
                height: 10,
              ),
              HintText(altThemeColor, details),
            ],
          ),
        ],
      ),
    );
  }
}
