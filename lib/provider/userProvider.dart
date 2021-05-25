import 'package:dio/dio.dart';
import 'package:famashi/config/api.dart';
import 'package:flutter/material.dart';

class User {
  String? email;
  String? firstname;
  String? lastname;
  String? profileImg;
  User(
      {required this.email,
      required this.firstname,
      required this.lastname,
      required this.profileImg});

  static get base {
    return new User(email: '', firstname: '', lastname: '', profileImg: null);
  }

  get img {
    return profileImg == null
        ? 'https://instagram.fbkk22-4.fna.fbcdn.net/v/t51.2885-15/e35/s1080x1080/174779557_377856969974255_5115754287508607467_n.jpg?tp=1&_nc_ht=instagram.fbkk22-4.fna.fbcdn.net&_nc_cat=111&_nc_ohc=UKBK5XkAvE0AX9hVIdS&edm=AP_V10EBAAAA&oh=3f1caf91d014925d74332acb0bca0160&oe=60C0C9B1'
        : uploadEndpoint + '/profile_img/' + profileImg.toString();
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
      user = modifyResponse(response.data["user"]);
      notifyListeners();
    } on DioError catch (error) {
      print(error);
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      await Dio().patch(apiEndpoint + '/user/password',
          data: {"old_password": oldPassword, "new_password": newPassword},
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
    } on DioError catch (error) {
      print(error);
    }
  }

  Future<void> updateProfile(String email, String firstname, String lastname,
      MultipartFile? file) async {
    try {
      var formData = FormData();
      if (file == null) {
        formData.fields.add(MapEntry('upload', 'false'));
      } else {
        formData.files.add(MapEntry('profile_img', file));
        formData.fields.add(MapEntry('upload', 'true'));
      }
      formData.fields.add(MapEntry('email', email));
      formData.fields.add(MapEntry('firstname', firstname));
      formData.fields.add(MapEntry('lastname', lastname));
      final response = await Dio().patch(apiEndpoint + '/user',
          data: formData,
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      print(response.data);
      user = modifyResponse(response.data["user"]);
      notifyListeners();
    } on DioError catch (error) {
      print(error);
    }
  }

  User modifyResponse(dynamic data) {
    return User(
        email: data["email"],
        firstname: data["firstname"],
        lastname: data["lastname"],
        profileImg: data["profile_pic"]);
  }
}
