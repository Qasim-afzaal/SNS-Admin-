import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPressed;

  const ContinueButton({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: const Text(
          "Continue",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
