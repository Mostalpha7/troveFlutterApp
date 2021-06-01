import 'package:flutter/material.dart';
import '../services/userService.dart';

class UserBloc extends ChangeNotifier {
  UserService userService = new UserService();

  Future<String> updatePassword(
    String oldPassword,
    String newPassword,
    String token,
  ) async {
    Map dataResponse = await userService.updatePassword(
      oldPassword: oldPassword.trim(),
      newPassword: newPassword.trim(),
      token: token,
    );

    if (dataResponse['success'] == null) {
      return throw (dataResponse['message']);
    } else {
      return dataResponse['message'];
    }
  }

  Future<String> editProfile({
    String address,
    String gender,
    String dob,
    String city,
    String state,
    String phoneNumber2,
    String token,
  }) async {
    Map dataResponse = await userService.editProfile(
      address: address.trim(),
      gender: gender.trim(),
      dob: dob.trim(),
      city: city.trim(),
      state: state.trim(),
      phoneNumber2: phoneNumber2.trim(),
      token: token,
    );
    print(dataResponse);
    if (dataResponse['success'] == null) {
      return throw (dataResponse['message']);
    } else {
      return dataResponse['message'];
    }
  }

  Future<String> updateNok({
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
    Map dataResponse = await userService.updateNok(
      nokFirstName: nokFirstName.trim(),
      nokLastName: nokLastName.trim(),
      address: address.trim(),
      gender: gender.trim(),
      city: city.trim(),
      state: state.trim(),
      phoneNumber: phoneNumber.trim(),
      password: password.trim(),
      token: token,
    );

    if (dataResponse['success'] == null) {
      return throw (dataResponse['message']);
    } else {
      return dataResponse['message'];
    }
  }

  Future<String> enterBankInfo({
    String accountNumber,
    String bankName,
    String bankCode,
    String password,
    String token,
  }) async {
    Map dataResponse = await userService.enterBankInfo(
      accountNumber: accountNumber.trim(),
      bankName: bankName.trim(),
      bankCode: bankCode.trim(),
      password: password.trim(),
      token: token,
    );

    if (dataResponse['success'] == null) {
      return throw (dataResponse['message']);
    } else {
      return dataResponse['message'];
    }
  }
}
