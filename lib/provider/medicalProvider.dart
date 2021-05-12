import 'package:dio/dio.dart';
import 'package:famashi/config/api.dart';
import 'package:famashi/config/enum.dart';
import 'package:flutter/material.dart';

class MedicalInfo {
  Gender? gender;
  DateTime? birthdate;
  double? weight;
  double? height;
  bool? isG6PD;
  bool? isLiver;
  bool? isKidney;
  bool? isGastritis;
  bool? isBreastfeeding;
  bool? isPregnant;
  MedicalInfo(
      {required this.gender,
      required this.birthdate,
      required this.weight,
      required this.height,
      required this.isG6PD,
      required this.isLiver,
      required this.isKidney,
      required this.isGastritis,
      required this.isBreastfeeding,
      required this.isPregnant});
  List<Map<String, String>> get report {
    return [
      {"title": "Gender", "detail": genderString.toString()},
      {"title": "Birthdate", "detail": birthdateString},
      {"title": "Weight", "detail": "${weight == null ? 0 : weight} kg."},
      {"title": "Height", "detail": "${height == null ? 0 : height} cm."},
      {
        "title": "G6PD",
        "detail": "${isG6PD == null ? 'No' : getBoolString(isG6PD!)}"
      },
      {
        "title": "Abnormal liver and liver disease",
        "detail": "${isLiver == null ? 'No' : getBoolString(isLiver!)}"
      },
      {
        "title": "Abnormal kidney and kidney disease",
        "detail": "${isKidney == null ? 'No' : getBoolString(isKidney!)}"
      },
      {
        "title": "Abnormal gastritis and gastritis disease",
        "detail": "${isGastritis == null ? 'No' : getBoolString(isGastritis!)}"
      },
      {
        "title": "Breastfeeding",
        "detail":
            "${isBreastfeeding == null ? 'No' : getBoolString(isBreastfeeding!)}"
      },
      {
        "title": "Pragnancy begin",
        "detail": "${isPregnant == null ? 'No' : getBoolString(isPregnant!)}"
      }
    ];
  }

  String getBoolString(bool val) {
    return val ? "Yes" : "No";
  }

  String? get genderString {
    return gender == null
        ? '-'
        : {Gender.Female: "Female", Gender.Male: "Male"}[gender];
  }

  String get birthdateString {
    return birthdate == null
        ? '-'
        : "${birthdate?.day.toString()}/${birthdate?.month.toString()}/${birthdate?.year.toString()}";
  }

  static MedicalInfo get base {
    return MedicalInfo(
        gender: null,
        birthdate: null,
        weight: null,
        height: null,
        isG6PD: null,
        isLiver: null,
        isKidney: null,
        isGastritis: null,
        isBreastfeeding: null,
        isPregnant: null);
  }
}

class MedicalProvider with ChangeNotifier {
  String? token;
  MedicalInfo? medicalInfo = MedicalInfo.base;
  MedicalProvider({required token, required medicalInfo});

  Future<void> fetchMeidcalInfo() async {
    try {
      final response = await Dio().get(apiEndpoint + '/medical',
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      medicalInfo = modifyResponse(response.data);
      notifyListeners();
    } on DioError catch (error) {
      print(error);
    }
  }

  Gender? getGenderString(n) {
    return {0: Gender.Male, 1: Gender.Female}[n];
  }

  DateTime? getDateTime(date) {
    if (date == null) {
      return null;
    }
    var extractedDate =
        date.split('T')[0].split('-').map((e) => int.parse(e)).toList();
    return DateTime(extractedDate[0], extractedDate[1], extractedDate[2]);
  }

  MedicalInfo modifyResponse(Map<String, dynamic> data) {
    return MedicalInfo(
        gender: getGenderString(data["gender"]),
        birthdate: getDateTime(data["birthdate"]),
        weight: data["weight"],
        height: data["height"],
        isG6PD: data["isG6PD"],
        isLiver: data["isLiver"],
        isKidney: data["isKidney"],
        isGastritis: data["isGastritis"],
        isBreastfeeding: data["isBreastfeeding"],
        isPregnant: data['isPregnant']);
  }
}
