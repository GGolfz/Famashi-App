import 'package:famashi/config/theme.dart';
import 'package:famashi/screen/AuthScreen.dart';
import 'package:famashi/screen/HealthInfoScreen.dart';
import 'package:famashi/screen/HomeScreen.dart';
import 'package:famashi/screen/NotificationScreen.dart';
import 'package:famashi/screen/medicine/MedicineAddScreen.dart';
import 'package:famashi/screen/medicine/MedicineDetailScreen.dart';
import 'package:famashi/screen/medicine/MedicineEditScreen.dart';
import 'package:famashi/screen/setting/SettingHomeScreen.dart';
import 'package:famashi/screen/setting/SettingNotificationScreen.dart';
import 'package:famashi/screen/setting/SettingPasswordScreen.dart';
import 'package:famashi/screen/setting/SettingProfileScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FamashiApp());
}

class FamashiApp extends StatelessWidget {
  var isAuth = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Famashi',
      theme: famashiTheme,
      home: isAuth ? AuthScreen() : HomeScreen(),
      routes: {
        HealthInfoScreen.routeName: (ctx) => HealthInfoScreen(),
        NotificationScreen.routeName: (ctx) => NotificationScreen(),
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
