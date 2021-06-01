import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:troveapp/components/cards/menuOptionCard.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/headerThree.dart';
import 'package:troveapp/components/typography/normalText.dart';
import 'package:troveapp/components/typography/smallText.dart';

class LoanOverview extends StatelessWidget {
  final Map loan;
  LoanOverview({this.loan});

  var formatedDate;

  DateFormat dateFormat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuOptionCard(
                  'Loan Overview',
                  '',
                  Icon(Icons.monetization_on, color: iconColor),
                ),
                SizedBox(height: minispacing),
                SizedBox(height: minispacing),
                NormalText(
                  'Loan Objective: ${loan['loanObjective']}',
                  blackColor,
                ),
                NormalText("Loan Period: ${loan['loanPeriod']}'", blackColor),
                NormalText(
                  "Loan Amount: USD${loan['loanAmount']}.00",
                  blackColor,
                ),
                NormalText(
                  "Total Returned: USD${loan['totalAmountReturned']}",
                  blackColor,
                ),
                NormalText(
                  'Repayment Amount: USD${loan['repaymentAmount'].toStringAsFixed(2)}',
                  blackColor,
                ),
                SizedBox(height: minispacing),
                SizedBox(height: minispacing),
                NormalText('Payment Schedule', blackColor),
                SizedBox(height: minispacing),
                for (var i in loan['paymentSchedule'])
                  Card(
                    elevation: 6,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText('NextDue: ${i['nextDue']}', blackColor),
                          Row(
                            children: [
                              SmallText('Status:', blackColor),
                              SizedBox(width: 10),
                              SmallText(
                                i['paid'] ? 'Paid' : 'Not Paid',
                                i['paid'] ? Colors.blueGrey : Colors.redAccent,
                              )
                            ],
                          ),
                        ],
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
