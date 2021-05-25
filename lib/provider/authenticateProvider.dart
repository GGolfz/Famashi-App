import 'package:dio/dio.dart';
import 'package:famashi/config/api.dart';
import 'package:famashi/utils/error.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticateProvider with ChangeNotifier {
  String? _token;
  AuthenticateProvider();

  bool get isAuth {
    return _token != null;
  }

  String? get token {
    return _token;
  }

  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await Dio().post(apiEndpoint + '/auth/login',
          data: {"email": email, "password": password});
      _token = response.data["token"];
      prefs.setString('userToken', _token!);
      notifyListeners();
    } on DioError catch (error) {
      if (error.response != null) {
        if (error.response!.statusCode == 500) {
          throw ErrorResponse(ErrorResponse.statusToMessage(500));
        } else {
          throw ErrorResponse(error.response!.data["message"]);
        }
      } else {
        throw ErrorResponse(ErrorResponse.statusToMessage(0));
      }
    }
  }

  Future<void> register(
      String email, String password, String firstname, String lastname) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await Dio().post(apiEndpoint + '/auth/register', data: {
        "email": email,
        "password": password,
        "firstname": firstname,
        "lastname": lastname
      });
      _token = response.data["token"];
      prefs.setString('userToken', _token!);
      notifyListeners();
    } on DioError catch (error) {
      if (error.response != null) {
        if (error.response!.statusCode == 500) {
          throw ErrorResponse(ErrorResponse.statusToMessage(500));
        } else {
          throw ErrorResponse(error.response!.data["message"]);
        }
      } else {
        throw ErrorResponse(ErrorResponse.statusToMessage(0));
      }
    }
  }

  Future<void> logout() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userToken')) return;
    final token = prefs.getString('userToken');
    _token = token;
    notifyListeners();
    try {
      await Dio().get(apiEndpoint + '/user',
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
    } catch (error) {
      prefs.clear();
      _token = null;
      notifyListeners();
    }
  }
}
