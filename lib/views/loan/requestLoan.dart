import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:troveapp/bloc/authBloc.dart';
import 'package:troveapp/bloc/loanBloc.dart';
import 'package:troveapp/components/buttons/appButton.dart';
import 'package:troveapp/components/inputs/amountInput.dart';
import 'package:troveapp/components/inputs/phoneNumberInput.dart';
import 'package:troveapp/components/inputs/textInput.dart';
import 'package:troveapp/components/loading/loadingState.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/smallText.dart';
import '../../components/cards/menuOptionCard.dart';

class RequestLoan extends StatefulWidget {
  static String tag = 'RequestLoan';

  @override
  _RequestLoanState createState() => _RequestLoanState();
}

class _RequestLoanState extends State<RequestLoan> {
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

  String loanAmount;
  String loanObjective;
  String loanPeriod;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    return LoadingState(
      isAsyncCall: isApiCallProcess,
      child: _displayScreen(context),
    );
  }

  @override
  Widget _displayScreen(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    final loanBloc = Provider.of<LoanBloc>(context);

    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      body: SafeArea(
        child: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                SizedBox(height: extralargespacing),
                SmallText('REQUEST LOAN ', mainColor),
                Form(
                  key: globalFormKey,
                  autovalidate: _autovalidate,
                  child: Column(
                    children: [
                      SizedBox(height: normalspacing),
                      TextInput(
                        hintText: 'Loan Objective',
                        icon: Icons.text_fields,
                        onChange: (e) {
                          setState(() {
                            loanObjective = e;
                          });
                        },
                      ),
                      SizedBox(height: normalspacing),
                      AmountInput(
                        amount: '6',
                        balance: '12',
                        label: 'Loan Period in months 6 - 9',
                        icon: Icons.ac_unit,
                        onChange: (e) {
                          setState(() {
                            loanPeriod = e;
                          });
                        },
                      ),
                      SizedBox(height: normalspacing),
                      AmountInput(
                        amount: '10',
                        balance: '14000',
                        label: 'Loan Amount',
                        icon: Icons.monetization_on_outlined,
                        onChange: (e) {
                          setState(() {
                            loanAmount = e;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: normalspacing),
                Container(
                  width: screenWidth * 0.5,
                  child: AppButton(
                    color: whiteColor,
                    backgroundColor: mainColor,
                    text: 'Send',
                    onTap: () async {
                      print(loanAmount);
                      print(loanObjective);
                      print(loanPeriod);
                      if (validateAndProceed()) {
                        startLoading();
                        loanBloc
                            .processLoan(
                          loanAmount: loanAmount,
                          loanObjective: loanObjective,
                          loanPeriod: loanPeriod,
                          token: authBloc.token,
                        )
                            .then((value) {
                          stopLoading();
                          Fluttertoast.showToast(
                            msg: value.toString(),
                            gravity: ToastGravity.TOP,
                          );

                          loanBloc.getActiveLoan(token: authBloc.token);
                          authBloc
                              .resetUserDetails(authBloc.token)
                              .then((value) {
                            print('done');
                          }).catchError((onError) {
                            print('not done');
                          });
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
