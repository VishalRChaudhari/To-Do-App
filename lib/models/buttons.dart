import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Buttons extends StatelessWidget {
  Buttons({super.key, required this.buttonName, required this.onPressed});

  final String buttonName;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
        color: Colors.yellow[300],
        textColor: Colors.black,
        child: Text(buttonName),
    );
  }
}

