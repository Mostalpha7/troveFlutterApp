import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:troveapp/bloc/authBloc.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/smallText.dart';
import 'package:troveapp/views/auth/login_view.dart';
import '../../components/cards/menuOptionCard.dart';

class LoanIndex extends StatelessWidget {
  static String tag = 'loan_index';

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      body: SafeArea(
        child: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                SizedBox(height: extralargespacing),
                SmallText('LOAN DASHBOARD', mainColor),
                SizedBox(height: normalspacing),
                MenuOptionCard(
                  'Request Loan',
                  'RequestLoan',
                  Icon(
                    Icons.monetization_on,
                    color: iconColor,
                  ),
                ),
                SizedBox(height: minispacing),
                MenuOptionCard(
                  'View Loan',
                  'ViewLoan',
                  Icon(
                    Icons.content_paste,
                    color: iconColor,
                  ),
                ),
                SizedBox(height: minispacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
