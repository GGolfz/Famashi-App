import 'package:dio/dio.dart';
import 'package:famashi/config/api.dart';
import 'package:flutter/material.dart';

class Medicine {
  final int medicineId;
  final String? medicineName;
  final String? description;
  final int totalAmount;
  final int remainAmount;
  final String? medicineUnit;
  final int dosageAmount;
  final String? dosageUnit;
  final List<int> reminder;
  final String? medicineImage;
  final String? medicineLeaflet;
  Medicine(
      {required this.medicineId,
      required this.medicineName,
      required this.description,
      required this.totalAmount,
      required this.remainAmount,
      required this.medicineUnit,
      required this.dosageAmount,
      required this.dosageUnit,
      required this.reminder,
      required this.medicineImage,
      required this.medicineLeaflet});
}

class MedicineProvider with ChangeNotifier {
  String? token;
  List<Medicine>? medicines;
  MedicineProvider({required this.token, this.medicines});

  Future<void> fetchMedicines() async {
    try {
      final response = await Dio().get(apiEndpoint + '/medicines',
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      medicines = modifyResponse(response.data);
      notifyListeners();
    } on DioError catch (error) {
      print(error);
    }
  }
  // Future<void> fetchMedicinesDetail(int medicineID) async {
  //   try {
  //     if(medicineID == int.parse(modifyResponse(medicineID).toString())){

  //     }
  //     final response = await Dio().get(apiEndpoint + '/medicines',
  //         options: Options(
  //             headers: {"Authorization": "Bearer " + token.toString()}));
  //     medicines = modifyResponse(response.data);
  //     // medicines.map((e) => e.medicineId);
  //     notifyListeners();
  //   } on DioError catch (error) {
  //     print(error);
  //   }
  // }

  Future<void> createMedicine(
      String medicineName,
      String description,
      int totalAmount,
      int dosagePerDose,
      String medicineUnit,
      String reminder,
      MultipartFile? medicineImage,
      MultipartFile? medicineLeaflet) async {
    try {
      FormData formData = new FormData();

      formData.fields.add(MapEntry("medicine_name", medicineName));
      formData.fields.add(MapEntry("description", description));
      formData.fields.add(MapEntry("total_amount", totalAmount.toString()));
      formData.fields.add(MapEntry("remain_amount", dosagePerDose.toString()));
      formData.fields.add(MapEntry("medicine_unit", medicineUnit));
      formData.fields.add(MapEntry("reminder", reminder.toString()));
      if (medicineImage != null) {
        formData.files.add(MapEntry('medicine_image', medicineImage));
        formData.fields.add(MapEntry('upload_image', 'true'));
      }
      if (medicineLeaflet != null) {
        formData.files.add(MapEntry('medicine_leaflet', medicineLeaflet));
        formData.fields.add(MapEntry('upload_leaflet', 'true'));
      }
      await Dio().post(apiEndpoint + '/medicines',
          data: formData,
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
    } on DioError catch (error) {
      print(error);
    }
  }

  Future<void> editMedicine(
      String medicineName,
      String description,
      int totalAmount,
      int dosagePerDose,
      String medicineUnit,
      List reminder,
      MultipartFile? medicineImage,
      MultipartFile? medicineLeaflet) async {
    try {
      FormData formData = new FormData();

      formData.fields.add(MapEntry("medicine_name", medicineName));
      formData.fields.add(MapEntry("description", description));
      formData.fields.add(MapEntry("total_amount", totalAmount.toString()));
      formData.fields.add(MapEntry("remain_amount", dosagePerDose.toString()));
      formData.fields.add(MapEntry("medicine_unit", medicineUnit));
      formData.fields.add(MapEntry("reminder", reminder.toString()));
      if (medicineImage != null) {
        formData.files.add(MapEntry('medicine_image', medicineImage));
        formData.fields.add(MapEntry('upload_image', 'true'));
      }
      if (medicineLeaflet != null) {
        formData.files.add(MapEntry('medicine_leaflet', medicineLeaflet));
        formData.fields.add(MapEntry('upload_leaflet', 'true'));
      }
      await Dio().patch(apiEndpoint + '/medicines/13',
          data: formData,
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
    } on DioError catch (error) {
      print(error);
    }
  }

  List<Medicine> modifyResponse(List<dynamic> data) {
    List<Medicine>? medicines = [];
    data.forEach((element) {
      medicines.add(Medicine(
          medicineId: element["medicine_id"] ?? 0,
          medicineName: element["medicine_name"] ?? "",
          description: element["description"] ?? "",
          totalAmount: element["total_amount"] ?? 0,
          remainAmount: element["remain_amount"] ?? 0,
          medicineUnit: element["medicine_unit"] ?? "",
          dosageAmount: element["dosage_amount"] ?? 0,
          dosageUnit: element["dosage_unit"] ?? "",
          reminder: element["reminder"] ?? [],
          medicineImage: element["medicine_image"],
          medicineLeaflet: element["medicine_leaflet"] ?? ""));
    });
    return medicines;
  }
}
