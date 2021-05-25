import 'package:famashi/config/theme.dart';
import 'package:famashi/provider/allergiesProvider.dart';
import 'package:famashi/provider/authenticateProvider.dart';
import 'package:famashi/provider/medicalProvider.dart';
import 'package:famashi/provider/medicineProvider.dart';
import 'package:famashi/provider/notificationProvider.dart';
import 'package:famashi/provider/userNotificationProvider.dart';
import 'package:famashi/provider/userProvider.dart';
import 'package:famashi/screen/health-info/HealthInfoEditScreen.dart';
import 'package:famashi/widget/utils/routing.dart';
import 'package:flutter/services.dart';
import 'package:famashi/screen/AuthScreen.dart';
import 'package:famashi/screen/health-info/HealthInfoScreen.dart';
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
  final routes = {
    '/': Consumer<AuthenticateProvider>(
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
    HealthInfoScreen.routeName: HealthInfoScreen(),
    HealthInfoEditScreen.routeName: HealthInfoEditScreen(),
    NotificationScreen.routeName: NotificationScreen(),
    MedicineAddScreen.routeName: MedicineAddScreen(),
    MedicineEditScreen.routeName: MedicineEditScreen(),
    MedicineDetailScreen.routeName: MedicineDetailScreen(),
    SettingHomeScreen.routeName: SettingHomeScreen(),
    SettingProfileScreen.routeName: SettingProfileScreen(),
    SettingPasswordScreen.routeName: SettingPasswordScreen(),
    SettingNotificationScreen.routeName: SettingNotificationScreen()
  };
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => AuthenticateProvider()),
          ChangeNotifierProxyProvider<AuthenticateProvider, UserProvider>(
              create: (ctx) => UserProvider(token: null, user: User.base),
              update: (ctx, auth, prev) =>
                  UserProvider(token: auth.token, user: prev?.user)),
          ChangeNotifierProxyProvider<AuthenticateProvider,
                  UserNotificationProvider>(
              create: (ctx) => UserNotificationProvider(
                  token: null, notify: UserNotifications.base),
              update: (ctx, auth, prev) {
                return UserNotificationProvider(
                    token: auth.token, notify: prev?.notify);
              }),
          ChangeNotifierProxyProvider<AuthenticateProvider,
                  NotificationProvider>(
              create: (ctx) =>
                  NotificationProvider(token: null, notify: Notifications.base),
              update: (ctx, auth, prev) {
                return NotificationProvider(
                    token: auth.token, notify: prev?.notify);
              }),
          ChangeNotifierProxyProvider<AuthenticateProvider, MedicalProvider>(
              create: (ctx) =>
                  MedicalProvider(token: null, medicalInfo: MedicalInfo.base),
              update: (ctx, auth, prev) {
                return MedicalProvider(
                    token: auth.token, medicalInfo: prev?.medicalInfo);
              }),
          ChangeNotifierProxyProvider<AuthenticateProvider, AllergiesProvider>(
              create: (ctx) =>
                  AllergiesProvider(token: null, allergyList: AllergyList.base),
              update: (ctx, auth, prev) {
                return AllergiesProvider(
                    token: auth.token, allergyList: prev?.allergyList);
              }),
          ChangeNotifierProxyProvider<AuthenticateProvider, MedicineProvider>(
              create: (ctx) => MedicineProvider(
                  token: null, medicines: [], selectedMedicines: null),
              update: (ctx, auth, prev) {
                return MedicineProvider(
                    token: auth.token,
                    medicines: prev?.medicines,
                    selectedMedicines: prev?.selectedMedicines);
              })
        ],
        child: MaterialApp(
            title: 'Famashi',
            theme: famashiTheme,
            onGenerateRoute: (setting) => NoAnimatedPageRoute(
                builder: (BuildContext ctx) => routes[setting.name.toString()]!,
                settings: setting)));
  }
}
