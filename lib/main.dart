import 'dart:io';

import 'package:earthkpru/states/authen.dart';
import 'package:earthkpru/states/service_officer.dart';
import 'package:earthkpru/states/service_student.dart';
import 'package:earthkpru/states/service_teacher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (context) => const Authen(),
  '/serviceStudent': (context) => const ServiceStudent(),
  '/serviceTeacher': (context) => const ServiceTeacher(),
  '/serviceOfficer': (context) => const ServiceOfficer(),
};

String? firstState;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? role = preferences.getString('role');
  print('role ===> $role');

  if (role == null) {
    firstState = '/authen';
    runApp(const MyApp());
  } else {
    switch (role) {
      case 'student':
        firstState = '/serviceStudent';
        runApp(const MyApp());
        break;
      case 'teacher':
        firstState = '/serviceTeacher';
        runApp(const MyApp());
        break;
      case 'officer':
        firstState = '/serviceOfficer';
        runApp(const MyApp());
        break;
      default:
        {
          firstState = '/authen';
          runApp(const MyApp());
        }
        break;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      routes: map,
      initialRoute: firstState ?? '/authen',
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // TODO: implement createHttpClient
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
