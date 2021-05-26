import 'package:dio/dio.dart';
import 'package:famashi/config/api.dart';
import 'package:famashi/provider/medicineProvider.dart';
import 'package:famashi/utils/error.dart';
import 'package:flutter/material.dart';

class MedicineNotify {
  int reminderId;
  int medicineId;
  String medicineName;
  int dosageAmount;
  String medicineUnit;
  int timeType;
  String? medicineImage;
  String time;
  MedicineNotify(
      {required this.reminderId,
      required this.medicineId,
      required this.medicineName,
      required this.dosageAmount,
      required this.medicineUnit,
      required this.medicineImage,
      required this.timeType,
      required this.time});
}

class Notifications {
  List<MedicineNotify> beforeMorning;
  List<MedicineNotify> afterMorning;
  List<MedicineNotify> beforeNoon;
  List<MedicineNotify> afterNoon;
  List<MedicineNotify> beforeEvening;
  List<MedicineNotify> afterEvening;
  List<MedicineNotify> bedtime;
  Notifications(
      {required this.beforeMorning,
      required this.afterMorning,
      required this.beforeNoon,
      required this.afterNoon,
      required this.beforeEvening,
      required this.afterEvening,
      required this.bedtime});
  static get base {
    return Notifications(
        beforeMorning: [],
        afterMorning: [],
        beforeNoon: [],
        afterNoon: [],
        beforeEvening: [],
        afterEvening: [],
        bedtime: []);
  }

  List getData(DateTime now) {
    List<List<MedicineNotify>> data = [
      this.beforeMorning,
      this.afterMorning,
      this.beforeNoon,
      this.afterNoon,
      this.beforeEvening,
      this.afterEvening,
      this.bedtime
    ];
    List<Map> resp = [];
    for (var i = 0; i < data.length; i++) {
      if (data[i].length > 0) {
        var timeList = data[i][0].time.split(':');
        if (now.isBefore(DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(timeList[0]),
            int.parse(timeList[1]),
            int.parse(timeList[2])))) {
          Map d = {};
          d["time_type"] = data[i][0].timeType;
          d["time"] = "${timeList[0]}:${timeList[1]}";
          d["data"] = data[i];
          resp.add(d);
        }
      }
    }
    return resp;
  }
}

class NotificationProvider with ChangeNotifier {
  String? token;
  Notifications? notify;
  NotificationProvider({required this.token, required this.notify});

  Future<void> fetchNotification() async {
    try {
      final response = await Dio().get(apiEndpoint + '/reminders',
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      notify =
          modifyResponse(response.data["reminders"], response.data["usages"]);
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

  Future<void> takeMedicine(int reminderId) async {
    try {
      final response = await Dio().patch(apiEndpoint + '/reminders/$reminderId',
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      notify =
          modifyResponse(response.data["reminders"], response.data["usages"]);
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

  Notifications modifyResponse(List data, List usage) {
    List<MedicineNotify> beforeMorning = [];
    List<MedicineNotify> afterMorning = [];
    List<MedicineNotify> beforeNoon = [];
    List<MedicineNotify> afterNoon = [];
    List<MedicineNotify> beforeEvening = [];
    List<MedicineNotify> afterEvening = [];
    List<MedicineNotify> bedtime = [];
    List usageBeforeMorning = [];
    List usageAfterMorning = [];
    List usageBeforeNoon = [];
    List usageAfterNoon = [];
    List usageBeforeEvening = [];
    List usageAfterEvening = [];
    List usageBedtime = [];
    usage.forEach((e) {
      switch (e["time_type"]) {
        case 0:
          usageBeforeMorning.add(e["medicines_id"]);
          break;
        case 1:
          usageAfterMorning.add(e["medicines_id"]);
          break;
        case 2:
          usageBeforeNoon.add(e["medicines_id"]);
          break;
        case 3:
          usageAfterNoon.add(e["medicines_id"]);
          break;
        case 4:
          usageBeforeEvening.add(e["medicines_id"]);
          break;
        case 5:
          usageAfterEvening.add(e["medicines_id"]);
          break;
        case 6:
          usageBedtime.add(e["medicines_id"]);
          break;
      }
    });
    data.forEach((e) {
      switch (e["time_type"]) {
        case 0:
          if (!usageBeforeMorning.contains(e["medicines_id"])) {
            beforeMorning.add(modifyMedicineNotify(e));
          }
          break;
        case 1:
          if (!usageAfterMorning.contains(e["medicines_id"])) {
            afterMorning.add(modifyMedicineNotify(e));
          }
          break;
        case 2:
          if (!usageBeforeNoon.contains(e["medicines_id"])) {
            beforeNoon.add(modifyMedicineNotify(e));
          }
          break;
        case 3:
          if (!usageAfterNoon.contains(e["medicines_id"])) {
            afterNoon.add(modifyMedicineNotify(e));
          }
          break;
        case 4:
          if (!usageBeforeEvening.contains(e["medicines_id"])) {
            beforeEvening.add(modifyMedicineNotify(e));
          }
          break;
        case 5:
          if (!usageAfterEvening.contains(e["medicines_id"])) {
            afterEvening.add(modifyMedicineNotify(e));
          }
          break;
        case 6:
          if (!usageBedtime.contains(e["medicines_id"])) {
            bedtime.add(modifyMedicineNotify(e));
          }
          break;
      }
    });
    return Notifications(
        beforeMorning: beforeMorning,
        afterMorning: afterMorning,
        beforeNoon: beforeNoon,
        afterNoon: afterNoon,
        beforeEvening: beforeEvening,
        afterEvening: afterEvening,
        bedtime: bedtime);
  }

  MedicineNotify modifyMedicineNotify(Map data) {
    return MedicineNotify(
        reminderId: data["id"] ?? 0,
        medicineId: data["medicines_id"] ?? 0,
        medicineName: data["medicine_name"] ?? "",
        dosageAmount: data["dosage_amount"] ?? 0,
        medicineUnit: data["medicine_unit"] ?? "",
        timeType: data["time_type"] ?? -1,
        medicineImage: data["medicine_image"],
        time: data["time"].split(' ')[1] ?? "");
  }
}
