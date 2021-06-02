import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:troveapp/bloc/authBloc.dart';
import 'package:troveapp/bloc/loanBloc.dart';
import 'package:troveapp/components/buttons/appButton.dart';
import 'package:troveapp/components/inputs/textInput.dart';
import 'package:troveapp/components/loading/loadingState.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/headerTwo.dart';
import 'package:troveapp/components/typography/normalText.dart';
import 'package:troveapp/views/dashboard/dashboard_view.dart';

class ConfirmOtpView extends StatefulWidget {
  static String tag = 'confirmOtp';

  @override
  _ConfirmOtpViewState createState() => _ConfirmOtpViewState();
}

class _ConfirmOtpViewState extends State<ConfirmOtpView> {
  // Contdown Timer
  Timer _timer;
  int _start = 120;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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

  String code = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    screenHeight = size.height;
    screenWidth = size.width;

    return new WillPopScope(
      onWillPop: () async => false,
      child: LoadingState(
        isAsyncCall: isApiCallProcess,
        child: _displayScreen(context),
      ),
    );
  }

  Widget _displayScreen(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    final loanBloc = Provider.of<LoanBloc>(context);
    return Scaffold(
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Container(
              // height: screenHeight * .9,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * .09),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/sms.png',
                            width: 55,
                          ),
                          SizedBox(height: 5),
                          HeaderTwo('Verification', blackColor),
                          SizedBox(height: 10),
                          NormalText('You will get an Otp via sms', altColor),
                          NormalText('Expires in ${_start}', altColor),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * .13),
                    Container(
                      child: Column(
                        children: <Widget>[
                          TextInput(
                              hintText: 'Enter OTP',
                              onChange: (e) {
                                setState(() {
                                  code = e;
                                });
                              }),
                          SizedBox(height: 20),
                          AppButton(
                            color: whiteColor,
                            backgroundColor: mainColor,
                            text: 'Verify',
                            onTap: () {
                              if (code.isNotEmpty) {
                                startLoading();
                                authBloc.verify2Fauth(code: code).then((value) {
                                  stopLoading();
                                  Fluttertoast.showToast(
                                    msg: value.toString(),
                                    gravity: ToastGravity.TOP,
                                  );

                                  loanBloc.getActiveLoan(token: authBloc.token);
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    Navigator.pushNamed(
                                        context, DashboardView.tag);
                                  });
                                }).catchError((onError) {
                                  stopLoading();
                                  Fluttertoast.showToast(
                                    msg: onError.toString(),
                                    backgroundColor: Colors.red,
                                    gravity: ToastGravity.CENTER,
                                  );
                                });
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Please enter OTP',
                                  backgroundColor: Colors.red,
                                  gravity: ToastGravity.CENTER,
                                );
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              NormalText(
                                "Didn't receive otp",
                                altColor,
                              ),
                              GestureDetector(
                                child: TextButton(
                                  onPressed: _start <= 0
                                      ? () {
                                          startLoading();
                                          authBloc
                                              .resendOtp(
                                                  email: authBloc.email,
                                                  password: authBloc.password)
                                              .then((value) {
                                            stopLoading();
                                            Fluttertoast.showToast(
                                              msg: value.toString(),
                                              gravity: ToastGravity.CENTER,
                                            );
                                            startTimer();
                                          }).catchError((errorMsg) {
                                            stopLoading();
                                            Fluttertoast.showToast(
                                              msg: errorMsg.toString(),
                                              gravity: ToastGravity.CENTER,
                                            );
                                          });
                                        }
                                      : null,
                                  child: Text(
                                    'Resend again',
                                    style: TextStyle(
                                      color: _start <= 0
                                          ? mainColor
                                          : Colors.black45,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
