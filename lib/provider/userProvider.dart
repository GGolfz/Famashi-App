import 'package:dio/dio.dart';
import 'package:famashi/config/api.dart';
import 'package:flutter/material.dart';

class User {
  String? firstname;
  String? lastname;
  String? profileImg;
  User(
      {required this.firstname,
      required this.lastname,
      required this.profileImg});

  static get base {
    return new User(firstname: '', lastname: '', profileImg: null);
  }

  get img {
    return profileImg ??
        'https://instagram.fbkk22-4.fna.fbcdn.net/v/t51.2885-15/e35/s1080x1080/174779557_377856969974255_5115754287508607467_n.jpg?tp=1&_nc_ht=instagram.fbkk22-4.fna.fbcdn.net&_nc_cat=111&_nc_ohc=UKBK5XkAvE0AX9hVIdS&edm=AP_V10EBAAAA&oh=3f1caf91d014925d74332acb0bca0160&oe=60C0C9B1';
  }
}

class UserProvider with ChangeNotifier {
  String? token;
  User? user;
  UserProvider({required this.token, required this.user});

  Future<void> fetchUser() async {
    try {
      final response = await Dio().get(apiEndpoint + '/user',
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      final data = response.data["user"];
      user = new User(
          firstname: data["firstname"],
          lastname: data["lastname"],
          profileImg: data["profile_pic"]);
      notifyListeners();
    } on DioError catch (error) {
      print(error);
    }
  }
}
