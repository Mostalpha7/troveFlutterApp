import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troveapp/bloc/authBloc.dart';
import 'package:troveapp/bloc/loanBloc.dart';
import 'package:troveapp/bloc/userBloc.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/views/auth/confirm_otp_view.dart';
import 'package:troveapp/views/auth/login_view.dart';
import 'package:troveapp/views/auth/reg_completed_view.dart';
import 'package:troveapp/views/auth/register_view.dart';
import 'package:troveapp/views/dashboard/dashboard_view.dart';
import 'package:troveapp/views/loan/index.dart';
import 'package:troveapp/views/loan/requestLoan.dart';
import 'package:troveapp/views/loan/viewLoan.dart';
import 'package:troveapp/views/user/editProfile.dart';
import './views/user/index.dart';

import './views/onboarding/splash_view.dart';
import './views/user/personalInformation.dart';
import './views/user/nokInformation.dart';
import './views/user/editNok.dart';
import './views/user/bankDetails.dart';
import './views/user/passwordUpdate.dart';
import './views/wallet/wallet.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthBloc()),
      ChangeNotifierProvider(create: (_) => LoanBloc()),
      ChangeNotifierProvider(create: (_) => UserBloc())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      LoginView.tag: (_) => LoginView(),
      RegisterView.tag: (_) => RegisterView(),
      RegCompletedView.tag: (_) => RegCompletedView(),
      ConfirmOtpView.tag: (_) => ConfirmOtpView(),
      DashboardView.tag: (_) => DashboardView(),
      UserIndex.tag: (_) => UserIndex(),
      EditProfile.tag: (_) => EditProfile(),
      ProfileInformation.tag: (_) => ProfileInformation(),
      NokInformation.tag: (_) => NokInformation(),
      EditNok.tag: (_) => EditNok(),
      BankDetails.tag: (_) => BankDetails(),
      PasswordUpdate.tag: (_) => PasswordUpdate(),
      Wallet.tag: (_) => Wallet(),
      LoanIndex.tag: (_) => LoanIndex(),
      RequestLoan.tag: (_) => RequestLoan(),
      ViewLoan.tag: (_) => ViewLoan(),
    };
    return MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: mainColor,
        accentColor: altColor,
      ),
      routes: routes,
    );
  }
}
