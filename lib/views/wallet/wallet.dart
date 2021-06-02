import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troveapp/bloc/authBloc.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/headerThree.dart';
import 'package:troveapp/components/typography/hintText.dart';
import 'package:troveapp/components/typography/normalText.dart';
import 'package:troveapp/components/typography/smallText.dart';
import '../../components/cards/menuOptionCard.dart';

class Wallet extends StatelessWidget {
  static String tag = 'wallet';

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      body: ListView(children: [
        DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                SizedBox(height: normalspacing),
                SmallText('WALLET', mainColor),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  height: screenHeight * 0.17,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: appBackgroundColor,
                        spreadRadius: 10.0,
                        blurRadius: 4.5,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          HintText(whiteColor, 'Main Balance'),
                          HeaderThree(
                            '${authBloc.authUser['wallet']['currency']} ${authBloc.authUser['wallet']['balance']}.00',
                            whiteColor,
                          ),
                        ],
                      ),
                      HintText(
                        whiteColor,
                        'Useable Portfolio Val - USD${authBloc.authUser['portfolioVals']['useablePortfolioVal']}',
                      )
                    ],
                  ),
                ),
                SizedBox(height: normalspacing),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HeaderThree('Your Assets', blackColor),
                    SizedBox(height: screenHeight * 0.009),
                    for (var i in authBloc.authUser['wallet']['portfolio'])
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  HintText(blackColor, '${i['symbol']}'),
                                  SmallText(
                                      'USD${i['pricePerShare']}.00', altColor)
                                ],
                              ),
                              NormalText(
                                '${i['totalQuantity']}.00',
                                blackColor,
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                ),
                SizedBox(height: minispacing),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HeaderThree('Portfolio Values', blackColor),
                    SizedBox(height: screenHeight * 0.009),
                    NormalText(
                      'Total Portfolio Val: USD${authBloc.authUser['portfolioVals']['totalPortfolioVal']}',
                      altColor,
                    ),
                    NormalText(
                      'Available Portfolio Val: USD${authBloc.authUser['portfolioVals']['availablePortfolioVal']}',
                      altColor,
                    ),
                    NormalText(
                      'Useable Portfolio Val: USD${authBloc.authUser['portfolioVals']['useablePortfolioVal']}',
                      altColor,
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.12),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
