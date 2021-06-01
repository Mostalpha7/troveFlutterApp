import 'package:flutter/material.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';

class MenuOptionCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String link;

  MenuOptionCard(this.title, this.link, this.icon);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(link);
      },
      child: Container(
        height: 0.1 * screenHeight,
        decoration: BoxDecoration(
            color: tertiaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: appBackgroundColor,
                  spreadRadius: 10.0,
                  blurRadius: 4.5)
            ]),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                icon,
                SizedBox(
                  width: 16,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: textbodysizesm),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
