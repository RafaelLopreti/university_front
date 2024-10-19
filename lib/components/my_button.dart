import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool removeDefaultShadow;
  final Color color;

  const SignButton({
    super.key,
    required this.onTap,
    required this.text,
    this.removeDefaultShadow = false,
    this.color =
        const Color.fromARGB(255, 44, 111, 255),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: removeDefaultShadow
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(4, 3),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
