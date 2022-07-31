// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:earthkpru/widgets/show_image.dart';
import 'package:flutter/material.dart';

class ShowImageInternet extends StatelessWidget {
  final String urlImage;
  const ShowImageInternet({
    Key? key,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return urlImage.isEmpty
        ? const ShowImage(
            path: 'images/icon5.png',
          )
        : Image.network(urlImage);
  }
}
