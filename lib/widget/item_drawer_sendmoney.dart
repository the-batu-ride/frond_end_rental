import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../constant/colors.dart';

Widget ItemDrawerSendMoney({
  required Size size,
  required String title,
}) {
  return GestureDetector(
    onTap: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width * .55,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.asset(
                  './assets/images/1.jpg', // Replace with your profile image asset
                  width: 35, // Adjust the width as needed
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 13),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 5),
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
