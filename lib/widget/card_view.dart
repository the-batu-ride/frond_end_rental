import 'package:flutter/material.dart';

Widget cardView({required String image, required String title}) {
  return GestureDetector(
    onTap: () {
      print("text");
    },
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
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.centerLeft,
              child: Text(title),
            ),
          ],
        ),
      ),
    ),
  );
}
