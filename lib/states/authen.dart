import 'package:dio/dio.dart';
import 'package:earthkpru/models/login_model.dart';
import 'package:earthkpru/models/permission_model.dart';
import 'package:earthkpru/states/service_officer.dart';
import 'package:earthkpru/states/service_student.dart';
import 'package:earthkpru/states/service_teacher.dart';
import 'package:earthkpru/utility/my_constant.dart';
import 'package:earthkpru/utility/my_dialog.dart';
import 'package:earthkpru/utility/my_service.dart';
import 'package:earthkpru/widgets/show_button.dart';
import 'package:earthkpru/widgets/show_form.dart';
import 'package:earthkpru/widgets/show_image.dart';
import 'package:earthkpru/widgets/show_text.dart';
import 'package:earthkpru/widgets/show_text_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool redEye = true;

  String? user;
  String? pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          child: Container(
            decoration: MyConstant().imageBox(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  newHead(boxConstraints),
                  centerContent(boxConstraints,
                      widget: ShowForm(
                        hint: 'ชื่อผู้ใช้งาน: ',
                        iconData: Icons.person_outline,
                        changeFunc: (p0) {
                          user = p0.trim();
                        },
                      )),
                  centerContent(boxConstraints,
                      widget: ShowForm(
                        hint: 'รหัสผ่าน: ',
                        iconData: Icons.lock_outline,
                        changeFunc: (p0) {
                          pass = p0.trim();
                        },
                        obsecu: redEye,
                        redEyeFunc: () {
                          setState(() {
                            redEye = !redEye;
                          });
                        },
                      )),
                  centerContent(boxConstraints,
                      widget: ShowButton(
                        label: 'Login',
                        pressFunc: () {
                          if ((user?.isEmpty ?? true) ||
                              (pass?.isEmpty ?? true)) {
                            // have Space
                            MyDialog(context: context).normalDialog(
                                title: 'มีช่องว่าง ?',
                                subTitle: 'กรุณากรอกให้ครบ ทุกช่องด้วย ค่ะ');
                          } else {
                            // No Space
                            processCheckLogin();
                          }
                        },
                      )),
                  centerContent(boxConstraints,
                      widget: ShowTextButton(
                        label: 'Forgot Password',
                        pressFunc: () {},
                      )),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Container centerContent(BoxConstraints boxConstraints,
      {required Widget widget}) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: boxConstraints.maxWidth * 0.6,
      height: 40,
      child: widget,
    );
  }

  SizedBox newHead(BoxConstraints boxConstraints) {
    return SizedBox(
      width: boxConstraints.maxWidth * 0.6,
      child: Row(
        children: [
          newLogo(boxConstraints),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ShowText(
                text: 'KPRU',
                textStyle: MyConstant().h1Style(),
              ),
              ShowText(
                text: 'ลงชื่อเข้าใช้งาน:',
                textStyle: MyConstant().h2Style(),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container newLogo(BoxConstraints boxConstraints) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: boxConstraints.maxWidth * 0.1,
      child: ShowImage(),
    );
  }

  Future<void> processCheckLogin() async {
    String urlAPI = 'https://mua.kpru.ac.th/FrontEnd_Mobile/user/login';

    Map<String, dynamic> map = {};
    map['user'] = user;
    map['password'] = pass;

    await Dio().post(urlAPI, data: map).then((value) async {
      // print('value form api ===> $value');

      Map<String, dynamic> data = value.data['data'];
      // print('data ===> $data');

      LoginModel loginModel = LoginModel.fromMap(data);
      // print('loginModel ===> ${loginModel.toMap()}');

      if (loginModel.success == "0") {
        MyDialog(context: context).normalDialog(
            title: 'Login False ?',
            subTitle: 'ไม่สามารถ Login ได้ User, Pasword ผิด');
      } else {
        checkTypeUser(token: loginModel.auth);
      }
    });
  }

  Future<void> checkTypeUser({required String token}) async {
    String urlAPIPermission =
        'https://mua.kpru.ac.th/FrontEnd_Mobile/user/premission';

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';

    await dio.get(urlAPIPermission).then((value) async {
      print('value from APIPermission ===> $value');

      var data = value.data['data']['data'];
      PermissionModel permissionModel = PermissionModel.fromMap(data);
      print('PermissionModel ===> ${permissionModel.toMap()}');

      await processSaveSharePreferance(
              token: token, permissionModel: permissionModel)
          .then((value) {
        MyService(context: context)
            .processRouteToService(role: permissionModel.role);
      });
    });
  }

  Future<void> processSaveSharePreferance({
    required String token,
    required PermissionModel permissionModel,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('name', permissionModel.name);
    preferences.setString('role', permissionModel.role);
    preferences.setString('token', token);
  }
}
