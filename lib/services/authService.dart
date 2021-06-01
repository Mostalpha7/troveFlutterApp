import 'dart:convert';

import 'package:http/http.dart';
import 'package:troveapp/config/index.dart';
import 'package:troveapp/utils/apiResponse.dart';
import 'package:troveapp/utils/exceptions.dart';

class AuthService {
  Future<Map> regiser({
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String password,
  }) async {
    try {
      Map map = {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password
      };

      var encodeBody = jsonEncode(map);

      Response response = await post(
        baseUrl + '/auth/register',
        headers: {"Content-Type": "application/json"},
        body: encodeBody,
      );

      print('object');
      Map decodedRes = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode > 200) {
        return new Exceptions(message: decodedRes['msg']).throwError();
      } else {
        ApiResponse registerRes = new ApiResponse(
          data: decodedRes['data'],
          success: true,
          message: decodedRes['msg'],
        );
        return registerRes.apiResponse();
      }
    } catch (e) {
      return new Exceptions(message: networkErrorMsg).throwError();
    }
  }

  Future<Map> loginService({String email, String password}) async {
    try {
      Map map = {'email': email, 'password': password};
      var encodeBody = jsonEncode(map);

      Response response = await post(
        baseUrl + '/auth/login',
        headers: {"Content-Type": "application/json"},
        body: encodeBody,
      );

      Map decodedBody = jsonDecode(response.body);

      if (response.statusCode > 200) {
        return new Exceptions(message: decodedBody['msg']).throwError();
      } else {
        ApiResponse loginRes = new ApiResponse(
          message: decodedBody['msg'],
          success: true,
          data: decodedBody['data'],
        );

        return loginRes.apiResponse();
      }
    } catch (e) {
      return new Exceptions(message: networkErrorMsg).throwError();
    }
  }

  Future<Map> verify2Fauth(
      {String email, String requestId, String code}) async {
    try {
      Map map = {"email": email, "requestId": requestId, "code": code};

      var encodedReq = jsonEncode(map);

      Response response = await post(
        baseUrl + '/auth/verify2Fauth',
        headers: {"Content-Type": "application/json"},
        body: encodedReq,
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
}
