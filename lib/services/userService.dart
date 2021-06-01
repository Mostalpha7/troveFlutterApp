import 'package:troveapp/config/index.dart';
import 'package:troveapp/utils/apiResponse.dart';
import 'package:troveapp/utils/exceptions.dart';
import 'dart:convert';
import 'package:http/http.dart';

class UserService {
  Exceptions exception = new Exceptions();

  Future<Map> updatePassword({
    String oldPassword,
    String newPassword,
    String token,
  }) async {
    try {
      Map map = {
        "password": oldPassword,
        "newPassword": newPassword,
      };
      var encodedBody = jsonEncode(map);
      Response response = await put(
        baseUrl + '/user/updatePassword',
        headers: {
          "Content-Type": "application/json",
          'auth-token': "${token}",
        },
        body: encodedBody,
      );

      Map decodedRes = jsonDecode(response.body);

      if (response.statusCode > 200) {
        return new Exceptions(message: decodedRes['msg']).throwError();
      } else {
        ApiResponse registerResponse = new ApiResponse(
            data: decodedRes['data'],
            message: decodedRes['msg'],
            success: true);
        return registerResponse.apiResponse();
      }
    } catch (e) {
      return new Exceptions(message: 'Network Error, check your internet')
          .throwError();
    }
  }

  Future<Map> editProfile({
    String address,
    String gender,
    String dob,
    String city,
    String state,
    String phoneNumber2,
    String token,
  }) async {
    try {
      Map map = {
        "address": address,
        "gender": gender,
        "dob": dob,
        "city": city,
        "state": state,
        "phoneNumber2": phoneNumber2,
      };
      var encodedBody = jsonEncode(map);
      Response response = await put(
        baseUrl + '/user/updateBasicProfile',
        headers: {
          "Content-Type": "application/json",
          'auth-token': "${token}",
        },
        body: encodedBody,
      );

      Map decodedRes = jsonDecode(response.body);
      print(decodedRes);

      if (response.statusCode > 200) {
        return new Exceptions(message: decodedRes['msg']).throwError();
      } else {
        ApiResponse registerResponse = new ApiResponse(
          data: decodedRes['data'],
          message: decodedRes['msg'],
          success: true,
        );
        return registerResponse.apiResponse();
      }
    } catch (e) {
      return new Exceptions(message: 'Network Error, check your internet')
          .throwError();
    }
  }

  Future<Map> getUser(String token) async {
    try {
      Map map = {};
      var encodedBody = jsonEncode(map);

      Response response = await get(
        baseUrl + '/user',
        headers: {
          "Content-Type": "application/json",
          'auth-token': "${token}",
        },
      );

      Map decodedRes = jsonDecode(response.body);

      if (response.statusCode > 200) {
        return new Exceptions(message: decodedRes['msg']).throwError();
      }

      ApiResponse loginResponse = new ApiResponse(
        data: {'data': decodedRes['data']},
        message: decodedRes['msg'],
        success: true,
      );
      return loginResponse.apiResponse();
    } catch (e) {
      // print(e);
      return new Exceptions(message: 'Network Error, check your internet')
          .throwError();
    }
  }

  Future<Map> updateNok({
    String nokFirstName,
    String nokLastName,
    String address,
    String gender,
    String city,
    String state,
    String phoneNumber,
    String password,
    String token,
  }) async {
    try {
      Map map = {
        "nokFirstName": nokFirstName,
        "nokLastName": nokLastName,
        "nokAddress": address,
        "nokGender": gender,
        "nokCity": city,
        "nokState": state,
        "nokPhoneNumber": phoneNumber,
        "password": password,
      };
      var encodedBody = jsonEncode(map);
      Response response = await put(
        baseUrl + '/user/udpateNokDetails',
        headers: {"Content-Type": "application/json", 'auth-token': "${token}"},
        body: encodedBody,
      );

      Map decodedRes = jsonDecode(response.body);

      if (response.statusCode > 200) {
        return new Exceptions(message: decodedRes['msg']).throwError();
      } else {
        ApiResponse registerResponse = new ApiResponse(
          data: decodedRes['data'],
          message: decodedRes['msg'],
          success: true,
        );
        return registerResponse.apiResponse();
      }
    } catch (e) {
      return new Exceptions(message: 'Network Error, check your internet')
          .throwError();
    }
  }

  Future<Map> enterBankInfo({
    String accountNumber,
    String bankName,
    String bankCode,
    String token,
    String password,
  }) async {
    try {
      Map map = {
        "password": password,
        "accountNumber": accountNumber,
        "bankName": bankName,
        "bankCode": bankCode,
      };
      var encodedBody = jsonEncode(map);
      Response response = await put(
        baseUrl + '/user/updateBankInfo',
        headers: {"Content-Type": "application/json", 'auth-token': "${token}"},
        body: encodedBody,
      );

      Map decodedRes = jsonDecode(response.body);

      if (response.statusCode > 200) {
        return new Exceptions(message: decodedRes['msg']).throwError();
      } else {
        ApiResponse registerResponse = new ApiResponse(
          data: decodedRes['data'],
          message: decodedRes['msg'],
          success: true,
        );
        return registerResponse.apiResponse();
      }
    } catch (e) {
      return new Exceptions(message: 'Network Error, check your internet')
          .throwError();
    }
  }
}
