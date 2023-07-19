import 'package:flutter/material.dart';

import '../constant/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        leading: const Icon(
          Icons.menu,
          color: primaryColor,
        ),
        title: Center(
          child: Image.asset('./assets/images/72x72.png'),
        ),
      ),
      // actions: [
      //   IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
      // ],
    );
  }
}
