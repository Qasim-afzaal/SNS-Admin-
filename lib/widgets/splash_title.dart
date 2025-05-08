import 'package:flutter/material.dart';

class SplashTitle extends StatelessWidget {
  const SplashTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Signage Player",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: Colors.red,
      ),
    );
  }
}
