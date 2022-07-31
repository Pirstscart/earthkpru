// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:earthkpru/states/service_officer.dart';
import 'package:earthkpru/states/service_student.dart';
import 'package:earthkpru/states/service_teacher.dart';
import 'package:flutter/material.dart';

class MyService {

  final BuildContext context;
  MyService({
    required this.context,
  });
  
  void processRouteToService({required String role}){
    
     switch (role) {
        case 'student':
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const ServiceStudent(),
              ),
              (route) => false);
          break;
        case 'teacher':
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const ServiceTeacher(),
              ),
              (route) => false);
          break;
        case 'officer':
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const ServiceOfficer(),
              ),
              (route) => false);
          break;
        default:
          {
            print('ไม่เข้าพวก');
          }
          break;
      }
  }
} // End Class
