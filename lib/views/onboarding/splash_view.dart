import 'package:flutter/material.dart';
import 'package:troveapp/components/buttons/appButton.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/typography/headerOne.dart';
import 'package:troveapp/components/typography/normalText.dart';
import 'package:troveapp/views/auth/login_view.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // backgroundColor: altColor,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(),
                  SizedBox(),
                  Image.asset(
                    'assets/images/onboard-image.png',
                    height: 300,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      HeaderOne('Fast and \nConvenient', blackColor),
                      SizedBox(height: 10),
                      NormalText(
                        'Installments repayment of loan made easy ...  No more queuse!',
                        blackColor,
                      ),
                      SizedBox(height: 40),
                      AppButton(
                        color: whiteColor,
                        backgroundColor: mainColor,
                        text: 'Get Started',
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, LoginView.tag);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
