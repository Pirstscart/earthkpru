import 'package:earthkpru/utility/my_constant.dart';
import 'package:earthkpru/widgets/show_button.dart';
import 'package:earthkpru/widgets/show_form.dart';
import 'package:earthkpru/widgets/show_image.dart';
import 'package:earthkpru/widgets/show_text.dart';
import 'package:earthkpru/widgets/show_text_button.dart';
import 'package:flutter/material.dart';

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
                          if ((user?.isEmpty??true)||(pass?.isEmpty??true)) {
                            
                          } else {
                            
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
}
