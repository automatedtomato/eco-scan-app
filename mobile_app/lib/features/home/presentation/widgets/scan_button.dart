import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ScanButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 120,
        height: 120,
        decoration: const BoxDecoration(
          color: Color(0xFF008080), // ティールカラー
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
