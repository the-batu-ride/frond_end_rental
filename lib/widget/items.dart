import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:ionicons/ionicons.dart';

Widget renderItemDashboard({
  required Size size,
  required String title,
  required Color color,
  required IconData icons,
}) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      alignment: Alignment.center,
      width: size.width * 0.150,
      height: size.height * 0.11,
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: size.width * 0.13,
              height: size.height * 0.06,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  color: whiteColor,
                  size: 26,
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
