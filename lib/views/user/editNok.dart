import 'package:fluttertoast/fluttertoast.dart';
import 'package:troveapp/bloc/authBloc.dart';
import 'package:troveapp/components/inputs/appDateInput.dart';
import 'package:troveapp/components/inputs/appDropdownInput.dart';
import 'package:troveapp/components/inputs/passwordInput.dart';
import 'package:troveapp/components/inputs/phoneNumberInput.dart';
import 'package:troveapp/components/inputs/textInput.dart';

import 'package:troveapp/components/loading/loadingState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/hintText.dart';
import '../../bloc/userBloc.dart';

class EditNok extends StatefulWidget {
  static String tag = 'EditNok';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditNok> {
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

  final formKey = new GlobalKey<FormState>();
  bool _autovalidate = false;
  bool validateAndProceed() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    setState(() => _autovalidate = true);
    return false;
  }

  String gender = '';
  String address = '';
  String city = '';
  String state = '';
  String phoneNumber = '';

  String firstName = '';
  String lastName = '';
  String password = '';

  List genderList = [
    {
      "display": "Male",
      "value": "Male",
    },
    {
      "display": "Female",
      "value": "Female",
    },
  ];

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

  @override
  Widget _displayScreen(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    final userBloc = Provider.of<UserBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  autovalidate: _autovalidate,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    children: <Widget>[
                      SizedBox(height: extralargespacing),
                      HintText(altThemeColor, 'EDIT NEXT OF KIN PROFILE'),
                      SizedBox(height: largespacing),
                      TextInput(
                        icon: Icons.person,
                        hintText: "First Name",
                        onChange: (e) => setState(() => firstName = e),
                      ),
                      SizedBox(height: minorspacing),
                      TextInput(
                        icon: Icons.person,
                        hintText: "Last Name",
                        onChange: (e) => setState(() => lastName = e),
                      ),
                      SizedBox(height: minorspacing),
                      AppDropdownInput(
                        items: ["Male", "Female"],
                        hintText: 'Select Gender',
                        result: (val) {
                          setState(() {
                            gender = val;
                          });
                        },
                      ),
                      SizedBox(height: minorspacing),
                      PhoneNumberInput(
                          hintText: 'Phone Number',
                          icon: Icons.phone_android,
                          limit: '11',
                          onChange: (e) => phoneNumber = e),
                      SizedBox(height: minorspacing),
                      TextInput(
                        icon: Icons.home,
                        hintText: "Home Address",
                        onChange: (e) => setState(() => address = e),
                      ),
                      SizedBox(height: minorspacing),
                      TextInput(
                        hintText: 'city',
                        icon: Icons.location_city,
                        onChange: (e) => setState(() => city = e),
                      ),
                      SizedBox(height: minorspacing),
                      TextInput(
                        hintText: 'State',
                        icon: Icons.location_city,
                        onChange: (e) => setState(() => state = e),
                      ),
                      SizedBox(height: minorspacing),
                      PasswordInput(
                        hintText: '**********',
                        onChange: (e) {
                          setState(() {
                            password = e;
                          });
                        },
                      ),
                      SizedBox(height: minorspacing),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        minWidth: 200.0,
                        height: 50.0,
                        onPressed: () async {
                          if (validateAndProceed()) {
                            startLoading();
                            await userBloc
                                .updateNok(
                              nokFirstName: firstName,
                              nokLastName: lastName,
                              address: address,
                              gender: gender,
                              city: city,
                              password: password,
                              phoneNumber: phoneNumber,
                              state: state,
                              token: authBloc.token,
                            )
                                .then((value) async {
                              await authBloc
                                  .resetUserDetails(authBloc.token)
                                  .then((value) {
                                print('done');
                              }).catchError((onError) {
                                print('not done');
                              });
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
                          } else {
                            Fluttertoast.showToast(
                              msg: 'All Fields are required.',
                              backgroundColor: Colors.red,
                            );
                          }
                        },
                        color: altThemeColor,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.check_circle_outline,
                              color: appBackgroundColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
