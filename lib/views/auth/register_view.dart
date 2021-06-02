import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:troveapp/bloc/authBloc.dart';
import 'package:troveapp/components/buttons/appButton.dart';
import 'package:troveapp/components/inputs/emailInput.dart';
import 'package:troveapp/components/inputs/passwordInput.dart';
import 'package:troveapp/components/inputs/phoneNumberInput.dart';
import 'package:troveapp/components/inputs/textInput.dart';
import 'package:troveapp/components/loading/loadingState.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/headerThree.dart';
import 'package:troveapp/components/typography/headerTwo.dart';
import 'package:troveapp/components/typography/hintText.dart';
import 'package:troveapp/views/auth/reg_completed_view.dart';

class RegisterView extends StatefulWidget {
  static String tag = 'register_view';

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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

  final globalFormKey = new GlobalKey<FormState>();
  bool _autovalidate = false;

  bool validateAndProceed() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    setState(() => _autovalidate = true);
    return false;
  }

  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;

  @override
  Widget build(BuildContext context) {
    return LoadingState(
      isAsyncCall: isApiCallProcess,
      child: _displayScreen(context),
    );
  }

  Widget _displayScreen(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    Widget Space() {
      return SizedBox(height: screenHeight * .017);
    }

    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.1),
                HeaderThree('Create an account', blackColor),
                HeaderTwo('Register Now', blackColor),
                SizedBox(height: 20),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.8,
                    child: Form(
                      key: globalFormKey,
                      autovalidate: _autovalidate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextInput(
                            hintText: 'First name',
                            onChange: (e) {
                              setState(() {
                                firstName = e;
                              });
                            },
                            icon: Icons.person,
                          ),
                          SizedBox(height: 10),
                          TextInput(
                            hintText: 'Last name',
                            onChange: (e) {
                              setState(() {
                                lastName = e;
                              });
                            },
                            icon: Icons.person,
                          ),
                          Space(),
                          EmailInput(
                            hintText: 'demo@gmail.com',
                            icon: Icons.email,
                            onChange: (e) {
                              setState(() {
                                email = e;
                              });
                            },
                          ),
                          Space(),
                          PhoneNumberInput(
                            hintText: 'Phone Number',
                            icon: Icons.phone_android,
                            limit: '11',
                            onChange: (e) {
                              phoneNumber = e;
                            },
                          ),
                          Space(),
                          PasswordInput(
                            hintText: '**********',
                            onChange: (e) {
                              setState(() {
                                password = e;
                              });
                            },
                          ),
                          Space(),
                          Space(),
                          AppButton(
                            color: whiteColor,
                            backgroundColor: mainColor,
                            text: 'Register',
                            onTap: () async {
                              if (validateAndProceed()) {
                                startLoading();
                                authBloc
                                    .register(
                                  firstName: firstName,
                                  lastName: lastName,
                                  email: email,
                                  phoneNumber: phoneNumber,
                                  password: password,
                                )
                                    .then((value) {
                                  stopLoading();
                                  Fluttertoast.showToast(
                                    msg: value.toString(),
                                    gravity: ToastGravity.TOP,
                                  );

                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.pushNamed(
                                        context, RegCompletedView.tag);
                                  });
                                }).catchError(
                                  (onError) {
                                    stopLoading();
                                    print(onError.toString());
                                    Fluttertoast.showToast(
                                      msg: onError.toString(),
                                      backgroundColor: Colors.red,
                                      gravity: ToastGravity.TOP,
                                    );
                                  },
                                );
                              }
                            },
                          ),
                          Space(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: HintText(blackColor, 'Back To Login'),
                          ),
                          Space(),
                          Space(),
                          Space(),
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  'assets/images/vector_icon3.png',
                                  height: 80,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
