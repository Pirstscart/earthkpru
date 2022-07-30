import 'package:flutter/material.dart';

class MyConstant {
  //field
  static Color primary = const Color.fromARGB(255, 5, 75, 7);
  static Color dark = const Color.fromARGB(255, 46, 3, 76);
  static Color light = const Color.fromARGB(255, 227, 161, 63);
  static Color active = const Color.fromARGB(255, 204, 51, 171);
  static Color button = Colors.white;

  //method

  BoxDecoration imageBox() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/bg.jpg'),
        fit: BoxFit.cover,
        opacity: 0.75,
      ),
    );
  }

  BoxDecoration gradianBox() {
    return BoxDecoration(
      gradient: RadialGradient(
        colors: <Color>[button, light],
        center: Alignment(-0.3, -0.3),
        radius: 0.75,
      ),
    );
  }

  BoxDecoration basicBox() {
    return BoxDecoration(color: light.withOpacity(0.5));
  }

  TextStyle h1Style() {
    return TextStyle(
      color: dark,
      fontSize: 48,
      fontWeight: FontWeight.bold,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h2Style() {
    return TextStyle(
      color: dark,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      color: dark,
      fontSize: 18,
      fontWeight: FontWeight.normal,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h3HintStyle() {
    return const TextStyle(
      color: Colors.grey,
      fontSize: 18,
      fontWeight: FontWeight.normal,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h3ActiveStyle() {
    return TextStyle(
      color: dark,
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h3ButtonStyle() {
    return TextStyle(
      color: button,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Kanit',
    );
  }
}
