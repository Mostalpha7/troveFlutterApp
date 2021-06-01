import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/hintText.dart';
import 'package:troveapp/components/typography/smallText.dart';
import 'package:flutter/material.dart';

class AppDropdownInput extends StatefulWidget {
  final List items;
  final String hintText;
  final Function result;

  AppDropdownInput({this.items, this.hintText, this.result});

  @override
  _AppDropdownInputState createState() => _AppDropdownInputState();
}

class _AppDropdownInputState extends State<AppDropdownInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.85 * screenWidth,
      height: 0.06 * screenHeight,
      color: secondaryColor,
      padding: EdgeInsets.all(10.0),
      child: DropDown(
        items: widget.items,
        hint: HintText(altColor, widget.hintText),
        onChanged: (val) => widget.result(val),
        isExpanded: true,
        showUnderline: false,
        customWidgets: widget.items.map((p) => buildDropDownRow(p)).toList(),
      ),
    );
  }

  Row buildDropDownRow(String item) {
    return Row(
      children: <Widget>[Expanded(child: HintText(mainColor, item))],
    );
  }
}
