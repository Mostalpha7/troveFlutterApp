import 'dart:convert';

import 'package:http/http.dart';
import 'package:troveapp/config/index.dart';
import 'package:troveapp/utils/apiResponse.dart';
import 'package:troveapp/utils/exceptions.dart';

class LoanService {
  Future<dynamic> getAcviteLoan({token}) async {
    try {
      Response response = await get(
        baseUrl + '/loan/viewActiveLoan',
        headers: {
          "Content-Type": "application/json",
          "auth-token": token,
        },
      );

      Map decodedRes = jsonDecode(response.body);

      if (response.statusCode > 200) {
        return new Exceptions(message: decodedRes['msg']).throwError();
      } else {
        ApiResponse apiResponse = new ApiResponse(
          data: decodedRes['data'],
          message: decodedRes['msg'],
          success: true,
        );
        return apiResponse.apiResponse();
      }
    } catch (e) {
      return new Exceptions(message: networkErrorMsg).throwError();
    }
  }

  Future<dynamic> processLoan({
    String loanAmount,
    String loanPeriod,
    String loanObjective,
    String token,
  }) async {
    try {
      Map request = {
        "loanPeriod": loanPeriod,
        "loanAmount": loanAmount,
        "loanObjective": loanObjective,
      };
      var encodedBody = jsonEncode(request);

      Response response = await post(
        baseUrl + '/loan/takeLoan',
        body: encodedBody,
        headers: {
          "Content-Type": "application/json",
          "auth-token": token,
        },
      );

      var decodedRes = jsonDecode(response.body);

      if (response.statusCode > 200) {
        return new Exceptions(message: decodedRes['msg']).throwError();
      } else {
        ApiResponse apiResponse = new ApiResponse(
          data: decodedRes['data'],
          message: decodedRes['msg'],
          success: true,
        );
        return apiResponse.apiResponse();
      }
    } catch (e) {
      return new Exceptions(message: networkErrorMsg).throwError();
    }
  }
}
