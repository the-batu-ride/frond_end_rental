import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../constant/colors.dart';

Widget ItemDrawerMenu({
  required Size size,
  required String title,
  required IconData icons,
}) {

  return GestureDetector(
    onTap: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 225,
          child: Row(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Icon(
                    color: whiteColor,
                    size: 20,
                    icons,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 13),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.chevron_forward_outline,
              color: mediumGreyColor,
            ),
          ),
        ),
      ],
    ),
  );
}
