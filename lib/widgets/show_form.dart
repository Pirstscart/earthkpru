// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:earthkpru/utility/my_constant.dart';

class ShowForm extends StatelessWidget {
  final String hint;
  final IconData iconData;
  final Function(String) changeFunc;
  final bool? obsecu;
  final Function()? redEyeFunc;
  const ShowForm({
    Key? key,
    required this.hint,
    required this.iconData,
    required this.changeFunc,
    this.obsecu,
    this.redEyeFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecu ?? false,
      onChanged: changeFunc,
      style: MyConstant().h3Style(),
      decoration: InputDecoration(
        fillColor: MyConstant.button.withOpacity(0.5),
        filled: true,
        suffixIcon: redEyeFunc == null
            ? Icon(
                iconData,
                color: MyConstant.dark,
              )
            : IconButton(
                onPressed: redEyeFunc,
                icon: Icon(
                  obsecu!
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined,
                  color: MyConstant.active,
                )),
        hintStyle: MyConstant().h3HintStyle(),
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: MyConstant.dark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: MyConstant.light),
        ),
      ),
    );
  }
}
