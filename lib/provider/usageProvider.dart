import 'package:dio/dio.dart';
import 'package:famashi/config/api.dart';
import 'package:famashi/utils/error.dart';
import 'package:flutter/material.dart';

class UsageHistory {
  String? medicineName;
  int? dosageAmount;
  String? medicineUnit;
  String dateTime;
  int? id;
  UsageHistory(
      {required this.id,
      required this.medicineName,
      required this.medicineUnit,
      required this.dosageAmount,
      required this.dateTime});
  String get title {
    return "$medicineName $dosageAmount $medicineUnit";
  }

  String get detail {
    return "$dateTime";
  }
}

class UsageProvider with ChangeNotifier {
  String? token;
  List<UsageHistory>? usageList;
  UsageProvider({required this.token, required this.usageList});

  Future<void> fetchUsageHistory() async {
    try {
      final response = await Dio().get(apiEndpoint + '/user/history',
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      usageList = modifyResponse(response.data);
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

  List<UsageHistory> modifyResponse(List<dynamic> data) {
    List<UsageHistory> usageList = [];
    data.forEach((element) {
      var date = element["date"].split('-');
      var time = element["time"].split('T')[1].split('Z')[0].split(':');
      String dateTime =
          "${int.parse(date[2])}/${int.parse(date[1])}/${int.parse(date[0])} ${int.parse(time[0])}:${int.parse(time[1])}";
      usageList.add(UsageHistory(
          id: element["id"],
          dosageAmount: element["amount"],
          medicineUnit: element["medicine_unit"],
          medicineName: element["medicine_name"],
          dateTime: dateTime));
    });
    return usageList;
  }
}
