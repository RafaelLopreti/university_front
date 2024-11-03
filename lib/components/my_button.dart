import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool activeShadow;
  final Color color;

  const Button({
    super.key,
    required this.onTap,
    required this.text,
    this.activeShadow = false,
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
          borderRadius: BorderRadius.circular(30),
          boxShadow: !activeShadow
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
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
