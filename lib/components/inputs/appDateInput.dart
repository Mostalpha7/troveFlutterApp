import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateInput extends StatefulWidget {
  final String label;
  final Widget icon;
  final ValueChanged onChange;

  AppDateInput({this.label, this.icon, this.onChange});

  @override
  _AppDateInputState createState() => _AppDateInputState();
}

class _AppDateInputState extends State<AppDateInput> {
  GlobalValidations globalValidations = new GlobalValidations();
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          width: screenWidth,
          height: 0.06 * screenHeight,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: DateTimeField(
            onChanged: widget.onChange,
            // autovalidate: true,
            autofocus: false,
            decoration: InputDecoration(
              hintText: widget.label,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              hintStyle: TextStyle(color: mainColor, fontSize: textinfosizesm),
              suffixIcon: widget.icon,
            ),
            format: format,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100),
              );
            },
          ),
        ),
      ],
    );
  }
}
