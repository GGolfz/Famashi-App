import 'package:dio/dio.dart';
import 'package:famashi/config/api.dart';
import 'package:flutter/material.dart';

class UserNotifications {
  String beforeMorning;
  String afterMorning;
  String beforeNoon;
  String afterNoon;
  String beforeEvening;
  String afterEvening;
  String bedtime;
  UserNotifications(
      {required this.beforeMorning,
      required this.afterMorning,
      required this.beforeNoon,
      required this.afterNoon,
      required this.beforeEvening,
      required this.afterEvening,
      required this.bedtime});
  static get base {
    return UserNotifications(
        beforeMorning: "07:00",
        afterMorning: "08:00",
        beforeNoon: "12:00",
        afterNoon: "13:00",
        beforeEvening: "17:00",
        afterEvening: "18:00",
        bedtime: "22:00");
  }
}

class UserNotificationProvider with ChangeNotifier {
  String? token;
  UserNotifications? notify;
  UserNotificationProvider({required this.token, required this.notify});

  Future<void> fetchNotification() async {
    try {
      final response = await Dio().get(apiEndpoint + '/user/notification',
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      notify = modifyResponse(response.data);
      notifyListeners();
    } on DioError catch (error) {
      print(error);
    }
  }

  Future<void> editNotification(Map<String, String> notification) async {
    try {
      final response = await Dio().patch(apiEndpoint + '/user/notification',
          data: {
            "BEFORE_MORNING": notification["BEFORE_MORNING"].toString(),
            "AFTER_MORNING": notification["AFTER_MORNING"].toString(),
            "BEFORE_NOON": notification["BEFORE_NOON"].toString(),
            "AFTER_NOON": notification["AFTER_NOON"].toString(),
            "BEFORE_EVENING": notification["BEFORE_EVENING"].toString(),
            "AFTER_EVENING": notification["AFTER_EVENING"].toString(),
            "BEDTIME": notification["BEDTIME"].toString(),
          },
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      notify = modifyResponse(response.data);
      notifyListeners();
    } on DioError catch (error) {
      print(error);
    }
  }

  UserNotifications modifyResponse(Map<String, dynamic> data) {
    return UserNotifications(
        beforeMorning: data["BEFORE_MORNING"].toString(),
        afterMorning: data["AFTER_MORNING"].toString(),
        beforeNoon: data["BEFORE_NOON"].toString(),
        afterNoon: data["AFTER_NOON"].toString(),
        beforeEvening: data["BEFORE_EVENING"].toString(),
        afterEvening: data["AFTER_EVENING"].toString(),
        bedtime: data["BEDTIME"].toString());
  }
}
