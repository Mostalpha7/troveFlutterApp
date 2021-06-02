import 'package:troveapp/bloc/authBloc.dart';
import 'package:troveapp/bloc/userBloc.dart';
import 'package:troveapp/components/cards/infoCard.dart';
import 'package:troveapp/components/inputs/passwordInput.dart';
import 'package:troveapp/components/loading/loadingState.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:troveapp/components/typography/smallText.dart';

class PasswordUpdate extends StatefulWidget {
  static String tag = 'PasswordUpdate';
  @override
  _PasswordUpdateState createState() => _PasswordUpdateState();
}

class _PasswordUpdateState extends State<PasswordUpdate> {
  String oldPassword;
  String newPassword;
  bool _autovalidate = false;
  final globalFormKey = new GlobalKey<FormState>();
  bool validateAndProceed() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    setState(() => _autovalidate = true);
    return false;
  }

  bool isApiCallProcess = false;
  void stopLoading() {
    setState(() {
      isApiCallProcess = false;
    });
  }

  void startLoading() {
    setState(() {
      isApiCallProcess = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return LoadingState(
      isAsyncCall: isApiCallProcess,
      child: _displayScreen(context),
    );
  }

  Widget _displayScreen(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    final authBloc = Provider.of<AuthBloc>(context);

    final InfoCard infoCard = new InfoCard(
      secondaryColor,
      'Keep your password secure always',
      Icon(
        Icons.security,
        color: Colors.black,
      ),
    );

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 40),
            child: Form(
              key: globalFormKey,
              autovalidate: _autovalidate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: largespacing),
                  SmallText('PASSWORD UPDATE', altThemeColor),
                  SizedBox(height: normalspacing),
                  infoCard,
                  SizedBox(height: extralargespacing),
                  PasswordInput(
                    hintText: 'Enter Old Password',
                    onChange: (value) {
                      setState(() {
                        oldPassword = value;
                      });
                    },
                  ),
                  SizedBox(height: minorspacing),
                  PasswordInput(
                    hintText: 'Enter New Password',
                    onChange: (value) {
                      newPassword = value;
                    },
                  ),
                  SizedBox(height: largespacing),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    minWidth: 200.0,
                    height: 50.0,
                    onPressed: () async {
                      if (validateAndProceed()) {
                        startLoading();
                        userBloc
                            .updatePassword(
                          oldPassword,
                          newPassword,
                          authBloc.token,
                        )
                            .then((value) {
                          stopLoading();
                          Fluttertoast.showToast(
                            msg: value.toString(),
                            gravity: ToastGravity.TOP,
                          );
                        }).catchError((onError) {
                          stopLoading();
                          Fluttertoast.showToast(
                            msg: onError.toString(),
                            backgroundColor: Colors.red,
                            gravity: ToastGravity.TOP,
                          );
                        });
                      }
                    },
                    color: altThemeColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Update', style: TextStyle(color: Colors.white)),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.lock, color: appBackgroundColor)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.5)
        ],
      ),
    );
  }
}
