import 'package:flutter/material.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/utils/validations.dart';

class PhoneNumberInput extends StatelessWidget {
  final String hintText;
  final String limit;
  final IconData icon;
  final ValueChanged onChange;

  PhoneNumberInput({this.hintText, this.limit, this.icon, this.onChange});
  GlobalValidations globalValidations = new GlobalValidations();

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
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            onChanged: onChange,
            validator: (e) {
              return globalValidations.phoneNumberValidator(e, limit);
            },
            keyboardType: TextInputType.phone,
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
          ),
        ),
      ],
    );
  }
}
