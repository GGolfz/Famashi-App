import 'package:dio/dio.dart';
import 'package:famashi/config/api.dart';
import 'package:famashi/utils/error.dart';
import 'package:flutter/material.dart';

class Allergy {
  String? medicineName;
  String? sideEffect;
  int? id;
  Allergy(this.id, this.medicineName, this.sideEffect);
}

class AllergyList {
  List<Allergy> allergies;
  AllergyList({this.allergies = const []});
  List<Map<String, dynamic>> get report {
    return allergies
        .map((e) =>
            {"id": e.id, "title": e.medicineName, "detail": e.sideEffect})
        .toList();
  }

  static AllergyList get base {
    return AllergyList(allergies: []);
  }
}

class AllergiesProvider with ChangeNotifier {
  String? token;
  AllergyList? allergyList;
  AllergiesProvider({required this.token, required this.allergyList});

  Future<void> fetchAllergies() async {
    try {
      final response = await Dio().get(apiEndpoint + '/allergies',
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      allergyList = modifyResponse(response.data);
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

  Future<void> createAllergy(String medicineName, String sideEffect) async {
    try {
      final response = await Dio().post(apiEndpoint + '/allergies',
          data: {"medicine_name": medicineName, "side_effect": sideEffect},
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      allergyList = modifyResponse(response.data);
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

  Future<void> deleteAllergy(int id) async {
    try {
      final response = await Dio().delete(apiEndpoint + '/allergies/$id',
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      allergyList = modifyResponse(response.data);
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

  AllergyList modifyResponse(List<dynamic> data) {
    List<Allergy> allergies = [];
    data.forEach((element) {
      allergies.add(Allergy(
          element["id"], element["medicine_name"], element["side_effect"]));
    });
    return AllergyList(allergies: allergies);
  }
}
