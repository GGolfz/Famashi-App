import 'package:dio/dio.dart';
import 'package:famashi/config/api.dart';
import 'package:famashi/utils/error.dart';
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
        ? ''
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

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      await Dio().patch(apiEndpoint + '/user/password',
          data: {"old_password": oldPassword, "new_password": newPassword},
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
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
      user = modifyResponse(response.data["user"]);
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

  User modifyResponse(dynamic data) {
    return User(
        email: data["email"],
        firstname: data["firstname"],
        lastname: data["lastname"],
        profileImg: data["profile_pic"]);
  }
}
