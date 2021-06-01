import 'package:flutter/material.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/utils/validations.dart';

class AmountInput extends StatefulWidget {
  final String label;
  final String amount;
  final String balance;
  final IconData icon;
  final ValueChanged<String> onChange;
  AmountInput({
    this.label,
    this.amount,
    this.balance,
    this.icon,
    this.onChange,
  });

  @override
  _AmountInputState createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  GlobalValidations globalValidations = new GlobalValidations();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      width: screenWidth,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        onChanged: widget.onChange,
        validator: (e) {
          return globalValidations.amountValidator(
              e, widget.amount, widget.balance);
        },
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          suffixIcon: Icon(
            widget.icon,
            color: Colors.black,
          ),
          hintText: widget.label,
          hintStyle: TextStyle(
            fontSize: hintsize,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
