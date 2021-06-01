import 'package:troveapp/components/typography/headerFour.dart';
import 'package:troveapp/components/typography/hintText.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final Color color;
  final String info;
  final String details;
  final IconData icon;

  UserInfoCard(this.color, this.info, this.details, this.icon);

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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: CircleAvatar(
              backgroundColor: secondaryColor,
              child: Icon(
                icon,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderFour(info, mainColor),
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
