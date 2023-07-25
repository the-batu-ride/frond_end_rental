import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';

Widget renderItemBalance({
  required Size size,
  required String title,
  required IconData icons,
}) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      alignment: Alignment.center,
      width: size.width * 0.150,
      height: size.height * 0.105,
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: purpleBalanceMenuColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  color: whiteColor,
                  size: 22,
                  icons,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: whiteColor),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}
