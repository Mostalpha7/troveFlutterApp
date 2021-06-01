import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:troveapp/bloc/authBloc.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/smallText.dart';
import 'package:troveapp/views/auth/login_view.dart';
import '../../components/cards/menuOptionCard.dart';

class UserIndex extends StatelessWidget {
  static String tag = 'user_index';

  logOut(context, authBloc) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          final authBloc = Provider.of<AuthBloc>(context);

          return AlertDialog(
            title: Text(
              'Confirmation',
              textAlign: TextAlign.center,
            ),
            content: Text('Are you sure you want to Sign Out'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context, 'Cancel'),
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () async {
                  await authBloc.logout().then((value) {
                    Navigator.pushNamed(context, LoginView.tag);
                  }).catchError((onError) {
                    Fluttertoast.showToast(
                      msg: onError.toString(),
                      backgroundColor: Colors.red,
                      gravity: ToastGravity.TOP_RIGHT,
                    );
                  });
                },
              ),
            ],
          );
        });
  }

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
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello",
                            style: TextStyle(fontSize: textinfosizesm),
                          ),
                          Text(
                            '${authBloc.authUser['user']['firstName']}  ${authBloc.authUser['user']['lastName']}',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: extralargespacing),
                SmallText('ACCOUNT SETTINGS', mainColor),
                SizedBox(height: normalspacing),
                MenuOptionCard(
                  'Personal Infomation',
                  'ProfileInformation',
                  Icon(
                    Icons.person_outline,
                    color: iconColor,
                  ),
                ),
                SizedBox(height: minispacing),
                MenuOptionCard(
                  'Nok Infomation',
                  'NokInformation',
                  Icon(
                    Icons.content_paste,
                    color: iconColor,
                  ),
                ),
                SizedBox(height: minispacing),
                MenuOptionCard(
                  'Update Bank Details',
                  'BankDetails',
                  Icon(
                    Icons.account_balance_wallet,
                    color: iconColor,
                  ),
                ),
                SizedBox(height: normalspacing),
                SmallText('SECURITY', mainColor),
                SizedBox(height: normalspacing),
                MenuOptionCard(
                  'Password Update',
                  'PasswordUpdate',
                  Icon(
                    Icons.lock,
                    color: iconColor,
                  ),
                ),
                SizedBox(height: minispacing),
                SizedBox(height: minispacing),
                GestureDetector(
                  onTap: () {
                    logOut(context, authBloc);
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
                            Icon(
                              Icons.exit_to_app,
                              color: iconColor,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Sign Out',
                              style: TextStyle(fontSize: textbodysizesm),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: extralargespacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
