import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String period;
  final String duration;
  final String image;

  const CourseCard(
      {super.key,
      required this.title,
      required this.period,
      required this.duration,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // substituir por Image.asset quando tiver
          Container(
            height: 100,
            color: Colors.grey[300],
            child: const Center(
                child: Text('Imagem do Curso',
                    style: TextStyle(color: Colors.black54))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(period, textAlign: TextAlign.center),
                Text(duration, textAlign: TextAlign.center),
                const SizedBox(height: 5),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                ),
                onPressed: () {
                  // Detalhes
                },
                child: const Text('Details'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
