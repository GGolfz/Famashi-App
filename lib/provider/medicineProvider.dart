import 'package:dio/dio.dart';
import 'package:famashi/config/api.dart';
import 'package:famashi/utils/error.dart';
import 'package:famashi/utils/format.dart';
import 'package:flutter/material.dart';

class Medicine {
  final int medicineId;
  final String? medicineName;
  final String? description;
  final int totalAmount;
  final int remainAmount;
  final String? medicineUnit;
  final int dosageAmount;
  final List<String> reminder;
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
      required this.reminder,
      required this.medicineImage,
      required this.medicineLeaflet});

  static get base {
    return Medicine(
        medicineId: 0,
        medicineName: "",
        description: "",
        totalAmount: 0,
        remainAmount: 0,
        medicineUnit: "",
        dosageAmount: 0,
        reminder: [],
        medicineImage: null,
        medicineLeaflet: null);
  }
}

class MedicineProvider with ChangeNotifier {
  String? token;
  List<Medicine>? medicines;
  Medicine? selectedMedicines;
  MedicineProvider(
      {required this.token, this.medicines, this.selectedMedicines});

  Future<void> fetchMedicines() async {
    try {
      final response = await Dio().get(apiEndpoint + '/medicines',
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      medicines = modifyResponse(response.data);
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

  Future<void> fetchMedicineById(String medicineID) async {
    try {
      final response = await Dio().get(apiEndpoint + '/medicines/$medicineID',
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      selectedMedicines = modifyResponseSingle(
          response.data["medicine"], response.data["reminder"]);
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
      formData.fields.add(MapEntry("dosage_amount", dosagePerDose.toString()));
      formData.fields.add(MapEntry("medicine_unit", medicineUnit));
      formData.fields.add(MapEntry("reminder", reminder.toString()));
      if (medicineImage != null) {
        formData.files.add(MapEntry('medicine_image', medicineImage));
        formData.fields.add(MapEntry('upload_image', 'true'));
      } else {
        formData.fields.add(MapEntry('upload_image', 'false'));
      }
      if (medicineLeaflet != null) {
        formData.files.add(MapEntry('medicine_leaflet', medicineLeaflet));
        formData.fields.add(MapEntry('upload_leaflet', 'true'));
      } else {
        formData.fields.add(MapEntry('upload_leaflet', 'false'));
      }
      final response = await Dio().post(apiEndpoint + '/medicines',
          data: formData,
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      medicines = modifyResponse(response.data);
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

  Future<void> editMedicine(
      String medicineId,
      String medicineName,
      String description,
      int totalAmount,
      int remainAmount,
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
      formData.fields.add(MapEntry("remain_amount", remainAmount.toString()));
      formData.fields.add(MapEntry("dosage_amount", dosagePerDose.toString()));
      formData.fields.add(MapEntry("medicine_unit", medicineUnit));
      formData.fields.add(MapEntry("reminder", reminder.toString()));
      if (medicineImage != null) {
        formData.files.add(MapEntry('medicine_image', medicineImage));
        formData.fields.add(MapEntry('upload_image', 'true'));
      } else {
        formData.fields.add(MapEntry('upload_image', 'false'));
      }
      if (medicineLeaflet != null) {
        formData.files.add(MapEntry('medicine_leaflet', medicineLeaflet));
        formData.fields.add(MapEntry('upload_leaflet', 'true'));
      } else {
        formData.fields.add(MapEntry('upload_leaflet', 'false'));
      }
      final response = await Dio().patch(apiEndpoint + '/medicines/$medicineId',
          data: formData,
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      medicines = modifyResponse(response.data);
      fetchMedicineById(medicineId);
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

  Future<void> deleteMedicine(String medicineID) async {
    try {
      final response = await Dio().delete(
          apiEndpoint + '/medicines/$medicineID',
          options: Options(
              headers: {"Authorization": "Bearer " + token.toString()}));
      medicines = modifyResponse(response.data);
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

  Medicine? modifyResponseSingle(
      Map<String, dynamic> medicineData, List<dynamic> reminder) {
    List<String> reminders = [];
    reminder.forEach((element) {
      reminders.add(formatTimeTypeToString(element["time_type"]).toString());
    });
    return Medicine(
        medicineId: medicineData["id"] ?? 0,
        medicineName: medicineData["medicine_name"] ?? "",
        description: medicineData["description"] ?? "",
        totalAmount: medicineData["total_amount"] ?? 0,
        remainAmount: medicineData["remain_amount"] ?? 0,
        medicineUnit: medicineData["medicine_unit"] ?? "",
        dosageAmount: medicineData["dosage_amount"] ?? 0,
        reminder: reminders,
        medicineImage: medicineData["medicine_image"],
        medicineLeaflet: medicineData["medicine_leaflet"]);
  }

  List<Medicine> modifyResponse(List<dynamic> data) {
    List<Medicine>? medicines = [];
    data.forEach((element) {
      medicines.add(Medicine(
          medicineId: element["id"] ?? 0,
          medicineName: element["medicine_name"] ?? "",
          description: element["description"] ?? "",
          totalAmount: element["total_amount"] ?? 0,
          remainAmount: element["remain_amount"] ?? 0,
          medicineUnit: element["medicine_unit"] ?? "",
          dosageAmount: element["dosage_amount"] ?? 0,
          reminder: [],
          medicineImage: element["medicine_image"],
          medicineLeaflet: element["medicine_leaflet"]));
    });
    return medicines;
  }
}
