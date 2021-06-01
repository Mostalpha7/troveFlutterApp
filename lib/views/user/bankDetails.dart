import 'package:troveapp/bloc/authBloc.dart';
import 'package:troveapp/bloc/userBloc.dart';
import 'package:troveapp/components/cards/infoCard.dart';
import 'package:troveapp/components/cards/infoCard2.dart';
import 'package:troveapp/components/inputs/passwordInput.dart';
import 'package:troveapp/components/inputs/phoneNumberInput.dart';
import 'package:troveapp/components/inputs/textInput.dart';
import 'package:troveapp/components/loading/loadingState.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:troveapp/components/typography/smallText.dart';
import '../../config/bank_details.dart';

class BankDetails extends StatefulWidget {
  static String tag = 'BankDetails';
  @override
  _BankDetailsState createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
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

  List<BankName> _bankNames = BankName.getBankNames();
  List<DropdownMenuItem<BankName>> _dropDownItems;
  BankName _selectedBank;
  List<DropdownMenuItem<BankName>> buildDropdownMenuItems(List bankNames) {
    List<DropdownMenuItem<BankName>> items = List();
    for (BankName _bankName in bankNames) {
      items.add(
          DropdownMenuItem(value: _bankName, child: Text(_bankName.bankName)));
    }
    return items;
  }

  onChangeDropdownItem(BankName selectedBank) {
    setState(() {
      _selectedBank = selectedBank;
      bankName = _selectedBank.bankName;
      bankCode = _selectedBank.bankCode;
    });
  }

  String bank, accountNumber, bankCode, bankName, accountName, password;
  bool verifyBtn = true;

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

  @override
  void initState() {
    super.initState();
    _dropDownItems = buildDropdownMenuItems(_bankNames);
  }

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

    final authBloc = Provider.of<AuthBloc>(context);
    final userBloc = Provider.of<UserBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Form(
                key: formKey,
                autovalidate: _autovalidate,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 24.0, right: 24.0),
                  children: <Widget>[
                    SmallText('VERIFY BANK DETAILS', altThemeColor),
                    SizedBox(height: largespacing),
                    Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bank Infomation',
                              style: TextStyle(
                                fontSize: textbodysizesm,
                                color: altThemeColor,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Text('Account Name: '),
                              ],
                            ),
                            Text(authBloc.authUser['user']['accountName'] ==
                                    null
                                ? "Not Set"
                                : '${authBloc.authUser['user']['accountName']}'),
                            Row(
                              children: <Widget>[
                                Text('Account Number: '),
                                Text(authBloc.authUser['user']
                                            ['accountNumber'] ==
                                        null
                                    ? "Not Set"
                                    : '${authBloc.authUser['user']['accountNumber']}'),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Bank Name: '),
                                Text(authBloc.authUser['user']['bankName'] ==
                                        null
                                    ? "Not Set"
                                    : '${authBloc.authUser['user']['bankName']}'),
                              ],
                            ),
                            SizedBox(height: normalspacing),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: normalspacing),
                    SizedBox(height: normalspacing),
                    SizedBox(height: normalspacing),
                    Text('Update Bank Details'),
                    SizedBox(height: normalspacing),
                    PhoneNumberInput(
                      icon: Icons.phone_android,
                      hintText: 'Account Number',
                      limit: '10',
                      onChange: (e) => setState(() => accountNumber = e),
                    ),
                    SizedBox(height: normalspacing),
                    Container(
                      width: 0.85 * screenWidth,
                      height: 0.06 * screenHeight,
                      color: secondaryColor,
                      padding: EdgeInsets.all(10.0),
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        items: _dropDownItems,
                        onChanged: onChangeDropdownItem,
                        value: _selectedBank,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Select Bank',
                          hintStyle: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    SizedBox(height: normalspacing),
                    PasswordInput(
                      hintText: '**********',
                      onChange: (e) {
                        setState(() {
                          password = e;
                        });
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
                        if (validateAndProceed() &&
                            bankCode != null &&
                            bankName != null) {
                          startLoading();
                          await userBloc
                              .enterBankInfo(
                            accountNumber: accountNumber,
                            bankName: bankName,
                            bankCode: bankCode,
                            password: password,
                            token: authBloc.token,
                          )
                              .then((value) async {
                            await authBloc
                                .resetUserDetails(authBloc.token)
                                .then((value) {})
                                .catchError((onError) {});
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
                      color: mainColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              verifyBtn
                                  ? 'Verify Account'
                                  : 'Save Account Details',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.arrow_forward, color: appBackgroundColor)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
