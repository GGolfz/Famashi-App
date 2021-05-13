import 'package:dio/dio.dart';
import 'package:famashi/config/api.dart';
import 'package:flutter/material.dart';

class Allergy {
  String? medicineName;
  String? sideEffect;
  Allergy(medicineName, sideEffect);
}

class AllergyList {
  List<Allergy> allergies;
  AllergyList({this.allergies = const []});
  List<Map<String, dynamic>> get report {
    return allergies
        .map((e) => {"title": e.medicineName, "detail": e.sideEffect})
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
      print(error);
    }
  }

  AllergyList modifyResponse(List<dynamic> data) {
    List<Allergy> allergies = [];
    data.forEach((element) {
      allergies.add(Allergy(element["medicine_name"], element["side_effect"]));
    });
    return AllergyList(allergies: allergies);
  }
}