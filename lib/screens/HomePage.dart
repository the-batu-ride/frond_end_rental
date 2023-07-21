import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0, left: 18.0),
                    child: Container(
                      width: size.width * 1,
                      height: size.height * 0.41,
                      decoration: const BoxDecoration(
                          color: darkpurpleColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(11),
                              bottomRight: Radius.circular(11))),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: size.width * 0.75,
                            height: size.height * 0.2,
                            child: const Text(
                              "Selamat Datang (Nama)",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Divider(
                              color: greyColor,
                              height: 10,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: size.width * 0.187,
                                  height: size.height * 0.15,
                                  decoration:
                                      const BoxDecoration(color: Colors.blue),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.calendar_month_outlined),
                                        ),
                                      ),
                                      const Text("Jadwal Event")
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: size.width * 0.187,
                                  height: size.height * 0.15,
                                  decoration:
                                      const BoxDecoration(color: Colors.blue),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons
                                              .chat_bubble_outline_rounded),
                                        ),
                                      ),
                                      const Text("Chat CS")
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: size.width * 0.187,
                                  height: size.height * 0.15,
                                  decoration:
                                      const BoxDecoration(color: Colors.blue),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.pedal_bike_outlined),
                                        ),
                                      ),
                                      const Text("Package Route")
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: size.width * 0.187,
                                  height: size.height * 0.15,
                                  decoration:
                                      const BoxDecoration(color: Colors.blue),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.check_box),
                                        ),
                                      ),
                                      const Text("Saldo")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
