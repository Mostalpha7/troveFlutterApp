import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troveapp/bloc/authBloc.dart';
import 'package:troveapp/bloc/loanBloc.dart';
import 'package:troveapp/components/buttons/appIconButton.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/headerFour.dart';
import 'package:troveapp/components/typography/headerThree.dart';
import 'package:troveapp/components/typography/hintText.dart';
import 'package:troveapp/components/typography/normalText.dart';
import 'package:troveapp/components/typography/smallText.dart';
import 'package:troveapp/views/loan/index.dart';
import 'package:troveapp/views/loan/loanOverview.dart';
import '../user/index.dart';
import '../wallet/wallet.dart';

class DashboardView extends StatefulWidget {
  static String tag = 'dashboad_view';
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('welcome');
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    final loanBloc = Provider.of<LoanBloc>(context);

    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return new WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: ListView(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SmallText('Welcome', altColor),
                                HeaderFour(
                                    '${authBloc.authUser['user']['firstName']} ',
                                    blackColor)
                              ],
                            ),
                            AppIconButton(
                              icon: Icons.person_outline,
                              backGroundColor: mainColor,
                              color: whiteColor,
                              onTap: () {
                                Navigator.pushNamed(context, UserIndex.tag);
                              },
                            )
                          ],
                        ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(height: screenHeight * 0.009),
                        HeaderThree('Your Assets', blackColor),
                        SizedBox(height: screenHeight * 0.009),
                        Column(
                          children: <Widget>[
                            for (var i in authBloc.authUser['wallet']
                                ['portfolio'])
                              Card(
                                elevation: 4,
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 5,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          HintText(
                                              blackColor, '${i['symbol']}'),
                                          SmallText(
                                              'USD${i['pricePerShare']}.00',
                                              altColor)
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
                        SizedBox(height: screenHeight * 0.009),
                        HeaderThree('Active Loans', blackColor),
                        SizedBox(height: 7),
                        loanBloc.activeLoan.length == 0
                            ? Text('You do not have an active loan')
                            : Column(
                                children: [
                                  for (var i in loanBloc.activeLoan)
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (ctx) => LoanOverview(
                                              loan: i,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: screenWidth,
                                        child: Card(
                                          elevation: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 8,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'Loan Objective: ${i['loanObjective']}'),
                                                Text(
                                                    'Loan Period: ${i['loanPeriod']}'),
                                                Text(
                                                  'Total Returned: USD${i['totalAmountReturned']}',
                                                ),
                                                Text(
                                                    'Loan Amount: USD${i['loanAmount']}.00'),
                                                Text(
                                                  'Repayment Amount: USD${i['repaymentAmount'].toStringAsFixed(2)}',
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.wallet_membership),
              title: new Text('Wallet'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              title: new Text('Profile'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on),
              title: Text('Loan'),
            )
          ],
          onTap: (int index) {
            if (index == 1) {
              Navigator.pushNamed(context, Wallet.tag);
              return;
            }

            if (index == 2) {
              Navigator.pushNamed(context, UserIndex.tag);
              return;
            }

            if (index == 3) {
              Navigator.pushNamed(context, LoanIndex.tag);
            }
          },
        ),
      ),
    );
  }
}
