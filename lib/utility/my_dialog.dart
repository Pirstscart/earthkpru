// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:earthkpru/utility/my_constant.dart';
import 'package:earthkpru/widgets/show_image.dart';
import 'package:earthkpru/widgets/show_text.dart';
import 'package:earthkpru/widgets/show_text_button.dart';
import 'package:flutter/material.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> normalDialog({
    required String title,
    required String subTitle,
    String? label,
    Function()? pressFunc,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: SizedBox(
            width: 80,
            child: ShowImage(),
          ),
          title: ShowText(
            text: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowText(text: subTitle),
        ),
        actions: [
          pressFunc == null
              ? const SizedBox()
              : ShowTextButton(label: label!, pressFunc: pressFunc),
          ShowTextButton(
            label: pressFunc == null ? 'OK' : 'CANCEL',
            pressFunc: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
