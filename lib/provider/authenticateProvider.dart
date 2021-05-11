import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
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
    _token = "Simple Token";
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    _token = "Simple Token";
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    notifyListeners();
  }
}
