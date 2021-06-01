import 'package:flutter/cupertino.dart';

class BankName {
  String bankCode;
  String bankName;

  BankName({@required this.bankCode, @required this.bankName});

  static List<BankName> getBankNames() {
    return <BankName>[
      BankName(bankCode: "044", bankName: 'Access Bank'),
      BankName(bankCode: "063", bankName: 'Access Bank (Diamond)'),
      BankName(bankCode: "035A", bankName: 'ALAT by WEMA'),
      BankName(bankCode: "401", bankName: 'ASO Savings and Loans'),
      BankName(bankCode: "023", bankName: 'Citibank Nigeria'),
      BankName(bankCode: "050", bankName: 'Ecobank Nigeria'),
      BankName(bankCode: "562", bankName: 'Ekondo Microfinance Bank'),
      BankName(bankCode: "070", bankName: 'Fidelity Bank'),
      BankName(bankCode: "011", bankName: 'First Bank of Nigeria'),
      BankName(bankCode: "214", bankName: 'First City Monument Bank'),
      BankName(bankCode: "058", bankName: 'Guaranty Trust Bank'),
      BankName(bankCode: "030", bankName: 'Heritage Bank'),
      BankName(bankCode: "301", bankName: 'Jaiz Bank'),
      BankName(bankCode: "082", bankName: 'Keystone Bank'),
      BankName(bankCode: "526", bankName: 'Parallex Bank'),
      BankName(bankCode: "076", bankName: 'Polaris Bank'),
      BankName(bankCode: "101", bankName: 'Providus Bank'),
      BankName(bankCode: "221", bankName: 'Stanbic IBTC Bank'),
      BankName(bankCode: "068", bankName: 'Standard Chartered Bank'),
      BankName(bankCode: "232", bankName: 'Sterling Bank'),
      BankName(bankCode: "100", bankName: 'Suntrust Bank'),
      BankName(bankCode: "032", bankName: 'Union Bank of Nigeria'),
      BankName(bankCode: "033", bankName: 'United Bank For Africa'),
      BankName(bankCode: "215", bankName: 'Unity Bank'),
      BankName(bankCode: "035", bankName: 'Wema Bank'),
      BankName(bankCode: "057", bankName: 'Zenith Bank'),
    ];
  }
}
