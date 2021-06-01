import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troveapp/bloc/loanBloc.dart';
import 'package:troveapp/components/buttons/appButton.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/normalText.dart';
import 'package:troveapp/views/loan/loanOverview.dart';
import 'package:troveapp/views/loan/requestLoan.dart';
import '../../components/cards/menuOptionCard.dart';

class ViewLoan extends StatelessWidget {
  static String tag = 'ViewLoan';

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              children: [
                MenuOptionCard(
                  'All Active Loan',
                  '',
                  Icon(Icons.monetization_on, color: iconColor),
                ),
                SizedBox(height: minispacing),
                loanBloc.activeLoan.length == 0
                    ? Container(
                        height: screenHeight * 0.26,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NormalText(
                                "You currently don't have an active loan",
                                altThemeColor,
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: screenWidth * 0.5,
                                child: AppButton(
                                  color: whiteColor,
                                  backgroundColor: altThemeColor,
                                  text: 'Get Loan',
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RequestLoan.tag,
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Loan Objective: ${i['loanObjective']}'),
                              Text('Loan Period: ${i['loanPeriod']}'),
                              Text(
                                'Total Returned: USD${i['totalAmountReturned']}',
                              ),
                              Text('Loan Amount: USD${i['loanAmount']}.00'),
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
            ),
          ),
        ),
      ),
    );
  }
}
