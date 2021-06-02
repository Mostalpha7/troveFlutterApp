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
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    final authBloc = Provider.of<AuthBloc>(context);
    Widget Space() {
      return SizedBox(height: screenHeight * .017);
    }

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: screenHeight * 0.2),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderThree('Welcome back', blackColor),
                  HeaderTwo('Login', blackColor),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Container(
                height: screenHeight * .8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                            Container(
                              width: double.infinity,
                              child: NormalText(
                                'Forgot Password ? / Reset',
                                blackColor,
                              ),
                            ),
                            Space(),
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
                            Space(),
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
        ],
      ),
    );
  }
}
