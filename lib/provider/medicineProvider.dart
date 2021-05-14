import 'package:dio/dio.dart';
import 'package:famashi/config/api.dart';
import 'package:flutter/material.dart';

class Medicine {
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
      {required this.medicineName,
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
  MedicineProvider({required this.token, required this.medicines});

  Future<void> createMedicine(
      MultipartFile? medicineImage, MultipartFile? medicineLeaflet) async {
    try {
      FormData formData = new FormData();

      formData.fields.add(MapEntry("medicine_name", "name"));
      formData.fields.add(MapEntry("description", "desc"));
      formData.fields.add(MapEntry("total_amount", "1000"));
      formData.fields.add(MapEntry("remain_amount", "200"));
      formData.fields.add(MapEntry("medicine_unit", "ml"));
      formData.fields.add(MapEntry("dosage_amount", "20"));
      formData.fields.add(MapEntry("dosage_unit", "ml"));
      formData.fields.add(MapEntry("reminder", "1,2,3,4"));
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
      MultipartFile? medicineImage, MultipartFile? medicineLeaflet) async {
    try {
      FormData formData = new FormData();

      formData.fields.add(MapEntry("medicine_name", "name"));
      formData.fields.add(MapEntry("description", "desc"));
      formData.fields.add(MapEntry("total_amount", "1000"));
      formData.fields.add(MapEntry("remain_amount", "200"));
      formData.fields.add(MapEntry("medicine_unit", "ml"));
      formData.fields.add(MapEntry("dosage_amount", "20"));
      formData.fields.add(MapEntry("dosage_unit", "ml"));
      formData.fields.add(MapEntry("reminder", "1,2,3,4"));
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
}
