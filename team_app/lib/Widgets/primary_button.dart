
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;

  const PrimaryButton({required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.08,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFF473F97), //Colors.blue.shade800,
      ),
      child: Text(
        buttonText,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
