import 'package:flutter/material.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/utils/validations.dart';

class EmailInput extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChange;
  const EmailInput({
    @required this.hintText,
    @required this.icon,
    @required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    GlobalValidations globalValidations = new GlobalValidations();
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          width: screenWidth,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            onChanged: onChange,
            cursorColor: mainColor,
            style: TextStyle(fontSize: textinfosizesm),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              suffixIcon: Icon(
                icon,
                color: Colors.black,
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: hintsize,
              ),
              border: InputBorder.none,
            ),
            validator: (e) {
              return globalValidations.emailValidator(e);
            },
          ),
        ),
      ],
    );
  }
}
