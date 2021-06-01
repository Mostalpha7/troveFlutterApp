import 'package:flutter/material.dart';
import 'package:troveapp/components/theme/color.dart';

import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/utils/validations.dart';

class PasswordInput extends StatefulWidget {
  final String hintText;
  final ValueChanged onChange;

  PasswordInput({this.hintText, this.onChange});

  @override
  _AppPasswordInputState createState() => _AppPasswordInputState();
}

class _AppPasswordInputState extends State<PasswordInput> {
  GlobalValidations globalValidations = new GlobalValidations();
  bool _obscureText = true;
  void togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            onChanged: widget.onChange,
            obscureText: _obscureText,
            validator: (e) {
              return globalValidations.passwordValidator(e);
            },
            cursorColor: mainColor,
            style: TextStyle(fontSize: textinfosizesm),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: togglePassword,
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black,
                ),
              ),
              hintText: widget.hintText,
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
