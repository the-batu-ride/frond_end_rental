import 'package:flutter/material.dart';

class CardEvent extends StatelessWidget {
  final String image;
  final String title;

  const CardEvent({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: 150,
        height: 240,
        child: Card(
          elevation: 1.0,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.centerLeft,
                child: Text(title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
