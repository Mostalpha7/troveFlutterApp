import 'package:flutter/material.dart';
import 'package:troveapp/services/loanService.dart';

class LoanBloc extends ChangeNotifier {
  List activeLoan = [];
  List allLoan = [];

  LoanService loanService = new LoanService();

  Future<dynamic> getActiveLoan({token}) async {
    Map response = await loanService.getAcviteLoan(token: token.trim());

    if (response['success'] == null) {
      return throw 'An error occured';
    } else {
      this.activeLoan = response['data'];
      notifyListeners();
      return;
    }
  }

  Future<String> processLoan({
    String loanAmount,
    String loanPeriod,
    String loanObjective,
    String token,
  }) async {
    Map response = await loanService.processLoan(
      loanAmount: loanAmount.trim(),
      loanObjective: loanObjective.trim(),
      loanPeriod: loanPeriod.trim(),
      token: token.trim(),
    );

    if (response['success'] == null) {
      return throw response['message'];
    } else {
      return response['message'];
    }
  }
}
