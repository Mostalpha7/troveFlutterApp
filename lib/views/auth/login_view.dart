import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:troveapp/bloc/authBloc.dart';
import 'package:troveapp/components/buttons/appButton.dart';
import 'package:troveapp/components/inputs/emailInput.dart';
import 'package:troveapp/components/inputs/passwordInput.dart';
import 'package:troveapp/components/loading/loadingState.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/headerThree.dart';
import 'package:troveapp/components/typography/headerTwo.dart';
import 'package:troveapp/components/typography/hintText.dart';
import 'package:troveapp/components/typography/normalText.dart';
import 'package:troveapp/views/auth/confirm_otp_view.dart';
import 'package:troveapp/views/auth/register_view.dart';

class LoginView extends StatefulWidget {
  static String tag = 'login';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    return new WillPopScope(
      onWillPop: () async => false,
      child: LoadingState(
        isAsyncCall: isApiCallProcess,
        child: _displayScreen(context),
      ),
    );
  }

  @override
  Widget _displayScreen(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(),
                  SizedBox(height: screenHeight * 0.15),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        HeaderThree('Welcome back', blackColor),
                        HeaderTwo('Login', blackColor),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Form(
                      key: globalFormKey,
                      autovalidate: _autovalidate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          EmailInput(
                            hintText: 'demo@gmail.com',
                            icon: Icons.email,
                            onChange: (e) {
                              setState(() {
                                email = e;
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          PasswordInput(
                            hintText: '**********',
                            onChange: (e) {
                              setState(() {
                                password = e;
                              });
                            },
                          ),
                          SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            child: NormalText(
                              'Forgot Password ? / Reset',
                              blackColor,
                            ),
                          ),
                          SizedBox(height: 15),
                          AppButton(
                            color: whiteColor,
                            backgroundColor: mainColor,
                            text: 'Login',
                            onTap: () async {
                              if (validateAndProceed()) {
                                startLoading();
                                authBloc
                                    .login(email: email, password: password)
                                    .then((value) {
                                  stopLoading();
                                  Fluttertoast.showToast(
                                    msg: value.toString(),
                                    gravity: ToastGravity.TOP,
                                  );
                                  Navigator.pushNamed(
                                      context, ConfirmOtpView.tag);
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
                          ),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RegisterView.tag);
                            },
                            child: HintText(blackColor, 'Create Account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/images/vector_icon3.png',
                            height: 90,
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
