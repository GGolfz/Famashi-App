import 'package:famashi/config/theme.dart';
import 'package:famashi/provider/authenticateProvider.dart';
import 'package:flutter/services.dart';
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
import 'package:provider/provider.dart';

void main() {
  runApp(FamashiApp());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class FamashiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => AuthenticateProvider())
        ],
        child: MaterialApp(
          title: 'Famashi',
          theme: famashiTheme,
          home: Consumer<AuthenticateProvider>(
              builder: (ctx, auth, _) => auth.isAuth
                  ? HomeScreen()
                  : FutureBuilder(
                      future: Future<bool>.sync(() async {
                        try {
                          await auth.tryAutoLogin();
                          return true;
                        } catch (error) {
                          return false;
                        }
                      }),
                      builder: (ctx, authResultSnapshot) => AuthScreen())),
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
        ));
  }
}
