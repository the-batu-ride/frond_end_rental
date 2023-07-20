import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../widget/BottomMenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: const Icon(
          Icons.menu,
          color: blackColor,
        ),
        title: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Image.asset(
              './assets/images/logo-remove.png',
              width: 45,
              height: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: blackColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, top: 8.0, bottom: 8.0, right: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.asset(
                './assets/images/1.jpg', // Replace with your profile image asset
                width: 30, // Adjust the width as needed
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 37, right: 37),
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  child: Container(
                    width: size.width * 1,
                    height: size.height * 0.215,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                    ),
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Container(
                      width: size.width * 0.83,
                      height: size.height * 0.41,
                      decoration: const BoxDecoration(
                          color: darkpurpleColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(11),
                              bottomRight: Radius.circular(11))),
                      child: const Column(
                        children: [
                          Text(
                            "Selamat Datang (Asfi)",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }
}
