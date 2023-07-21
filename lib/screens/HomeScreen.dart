import 'package:flutter/material.dart';
import 'package:frond_end_rental/widget/items.dart';
import 'package:ionicons/ionicons.dart';

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
      drawer: Drawer(
        child: Container(),
      ),
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: Builder(
          builder: (cont) => InkWell(
            onTap: () {
              Scaffold.of(cont).openDrawer();
            },
            child: const Icon(
              Icons.menu,
              color: blackColor,
            ),
          ),
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
                    height: size.height * 0.12,
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
                      height: size.height * 0.25,
                      decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(11),
                          bottomRight: Radius.circular(11),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            alignment: Alignment.centerLeft,
                            width: size.width * 0.75,
                            height: size.height * 0.11,
                            child: const Text(
                              "Selamat Datang (Nama)",
                              style: TextStyle(
                                color: blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Divider(
                              color: lightGreyColor,
                              height: 4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  renderItemDashboard(
                                    size: size,
                                    title: 'Jadwal Event',
                                    color: pinkEvent,
                                    icons: Ionicons.calendar_outline,
                                  ),
                                  renderItemDashboard(
                                    size: size,
                                    title: 'Chat CS',
                                    color: purpleChat,
                                    icons: Ionicons.chatbox_ellipses_outline,
                                  ),
                                  renderItemDashboard(
                                    size: size,
                                    title: 'Package Route',
                                    color: yellowBicycle,
                                    icons: Ionicons.bicycle_outline,
                                  ),
                                  renderItemDashboard(
                                    size: size,
                                    title: 'Saldo',
                                    color: greenSaldo,
                                    icons: Ionicons.file_tray_outline,
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding:
                  EdgeInsets.only(top: 30.0, right: 20, left: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Berita Terbaru",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: mediumGreyColor),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: bottomMenu(),
    );
  }
}
