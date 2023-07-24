import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';

Widget renderItemDashboard({
  required Size size,
  required String title,
  required Color color,
  required IconData icons,
  Function()? handleClick,
}) {
  return GestureDetector(
    onTap: handleClick,
    child: Container(
      alignment: Alignment.center,
      width: size.width * 0.150,
      height: size.height * 0.10,
      // decoration: BoxDecoration(color: Colors.amber),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 37,
              height: 37,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  color: whiteColor,
                  size: 18,
                  icons,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 11),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}
