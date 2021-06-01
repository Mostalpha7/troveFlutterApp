import 'package:flutter/material.dart';
import 'package:troveapp/components/theme/sizes.dart';

class InfoCard extends StatelessWidget {
  final Color color;
  final String info;
  final Widget icon;

  InfoCard(this.color, this.info, this.icon);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Container(
      height: 0.15 * screenHeight,
      decoration: BoxDecoration(
        color: color,
        // color: coAppBarColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              icon,
              SizedBox(
                width: 16,
              ),
              Text(
                info,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: textinfosizesm,
                  color: Colors.grey[700],
                ),
                maxLines: 2,
                softWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
