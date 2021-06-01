import 'package:flutter/material.dart';
import 'package:troveapp/components/buttons/appButton.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/headerThree.dart';
import 'package:troveapp/components/typography/headerTwo.dart';
import 'package:troveapp/components/typography/normalText.dart';
import 'package:troveapp/views/auth/login_view.dart';

class RegCompletedView extends StatelessWidget {
  static String tag = 'reg_completed';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: screenHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/vector_icon3.png',
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20),
                          Image.asset(
                            'assets/images/onboard-image.png',
                            height: 300,
                          ),
                          HeaderThree('Registration Completed.', mainColor),
                          SizedBox(height: 20),
                          NormalText(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer",
                            altColor,
                          ),
                          SizedBox(height: 20),
                          AppButton(
                              color: whiteColor,
                              backgroundColor: mainColor,
                              text: 'Login',
                              onTap: () {
                                Navigator.pushNamed(context, LoginView.tag);
                              }),
                          Container(height: screenHeight * 0.017)
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
