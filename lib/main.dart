import 'package:famashi/screen/AuthScreen.dart';
import 'package:famashi/screen/HealthInfoScreen.dart';
import 'package:famashi/screen/NotificationScreen.dart';
import 'package:famashi/screen/medicine/MedicineAddScreen.dart';
import 'package:famashi/screen/medicine/MedicineDetailScreen.dart';
import 'package:famashi/screen/medicine/MedicineEditScreen.dart';
import 'package:famashi/screen/medicine/MedicineHomeScreen.dart';
import 'package:famashi/screen/setting/SettingHomeScreen.dart';
import 'package:famashi/screen/setting/SettingNotificationScreen.dart';
import 'package:famashi/screen/setting/SettingPasswordScreen.dart';
import 'package:famashi/screen/setting/SettingProfileScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FamashiApp());
}

class FamashiApp extends StatelessWidget {
  var isAuth = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Famashi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isAuth ? AuthScreen() : AuthScreen(),
      routes: {
        HealthInfoScreen.routeName: (ctx) => HealthInfoScreen(),
        NotificationScreen.routeName: (ctx) => NotificationScreen(),
        MedicineHomeScreen.routeName: (ctx) => MedicineHomeScreen(),
        MedicineAddScreen.routeName: (ctx) => MedicineAddScreen(),
        MedicineEditScreen.routeName: (ctx) => MedicineEditScreen(),
        MedicineDetailScreen.routeName: (ctx) => MedicineDetailScreen(),
        SettingHomeScreen.routeName: (ctx) => SettingHomeScreen(),
        SettingProfileScreen.routeName: (ctx) => SettingProfileScreen(),
        SettingPasswordScreen.routeName: (ctx) => SettingPasswordScreen(),
        SettingNotificationScreen.routeName: (ctx) =>
            SettingNotificationScreen()
      },
    );
  }
}
