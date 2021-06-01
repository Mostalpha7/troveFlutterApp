import 'package:flutter/material.dart';
import 'package:troveapp/services/authService.dart';
import '../services/userService.dart';

class AuthBloc extends ChangeNotifier {
  Map authUser = {};
  String email;
  String token;
  String twoFactoryRequestId;
  String password;

  AuthService authService = new AuthService();
  UserService userService = new UserService();

  Future<String> register({
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String password,
  }) async {
    Map registerRes = await authService.regiser(
      firstName: firstName.trim(),
      lastName: lastName.trim(),
      email: email.trim(),
      phoneNumber: phoneNumber.trim(),
      password: password.trim(),
    );

    if (registerRes['success'] == null) {
      return throw registerRes['message'];
    } else {
      return registerRes['message'];
    }
  }

  Future<String> login({String email, String password}) async {
    Map loginRes = await authService.loginService(
      email: email.trim(),
      password: password.trim(),
    );

    if (loginRes['success'] == null) {
      return throw loginRes['message'];
    } else {
      this.email = email;
      this.password = password;
      this.twoFactoryRequestId = loginRes['data']['requestId'];
      notifyListeners();
      return loginRes['message'];
    }
  }

  Future<String> verify2Fauth({String code}) async {
    Map verifyRes = await authService.verify2Fauth(
      code: code.trim(),
      email: this.email,
      requestId: this.twoFactoryRequestId,
    );

    if (verifyRes['success'] == null) {
      return throw verifyRes['message'];
    } else {
      this.password = '';
      this.token = verifyRes['data']['token'];
      this.authUser = verifyRes['data']['userData'];
      notifyListeners();
      return verifyRes['message'];
    }
  }

  Future<String> resetUserDetails(String token) async {
    Map loginResponse = await userService.getUser(token.trim());
    print('ada');
    print(loginResponse);

    if (loginResponse['success'] == null) {
      return throw (loginResponse['message']);
    } else {
      print(loginResponse['data']);
      Map activeUser = loginResponse['data']['data'];
      this.authUser = activeUser;
      print(this.authUser);
      notifyListeners();
      return loginResponse['message'];
    }
  }

  Future<bool> logout() async {
    this.authUser = {};
    notifyListeners();
    this.email = '';
    this.token = '';
    this.twoFactoryRequestId = '';
    this.password = "";
    return true;
  }
}
