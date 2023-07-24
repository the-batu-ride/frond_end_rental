import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/widget/item_drawer_menu.dart';
import 'package:frond_end_rental/widget/item_drawer_sendmoney.dart';
import 'package:ionicons/ionicons.dart';

import 'render_item_balance.dart';

class DrawerValue extends StatelessWidget {
  const DrawerValue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * .38,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: Image.asset(
                          './assets/images/1.jpg', // Replace with your profile image asset
                          width: 40, // Adjust the width as needed
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sebastian Doe',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '4029209',
                            style: TextStyle(color: mediumGreyColor),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Ionicons.close,
                      color: purpleChat,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            width: 310,
            decoration: const BoxDecoration(color: purpleChat),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Balance",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: whiteColor),
                ),
                const Text(
                  "\$ 2,562.50",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 29,
                      color: whiteColor),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    renderItemBalance(
                      size: size,
                      title: 'Deposit',
                      icons: Ionicons.add_outline,
                    ),
                    renderItemBalance(
                      size: size,
                      title: 'Witdraw',
                      icons: Ionicons.arrow_down_outline,
                    ),
                    renderItemBalance(
                      size: size,
                      title: 'Send',
                      icons: Ionicons.arrow_forward_outline,
                    ),
                    renderItemBalance(
                      size: size,
                      title: 'My Cards',
                      icons: Ionicons.card_outline,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            width: 310,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                const Text(
                  "Menu",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: mediumGreyColor),
                ),
                const SizedBox(height: 15),
                ItemDrawerMenu(
                    size: size,
                    title: "Overview",
                    icons: Ionicons.pie_chart_outline),
                const SizedBox(height: 10),
                ItemDrawerMenu(
                    size: size,
                    title: "Pages",
                    icons: Ionicons.document_text_outline),
                const SizedBox(height: 10),
                ItemDrawerMenu(
                    size: size,
                    title: "Components",
                    icons: Ionicons.apps_outline),
                const SizedBox(height: 10),
                ItemDrawerMenu(
                    size: size,
                    title: "My Cards",
                    icons: Ionicons.card_outline),
                const SizedBox(height: 20),
                const Text(
                  "Others",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: mediumGreyColor),
                ),
                const SizedBox(height: 15),
                ItemDrawerMenu(
                    size: size,
                    title: "Settings",
                    icons: Ionicons.settings_outline),
                const SizedBox(height: 10),
                ItemDrawerMenu(
                    size: size,
                    title: "Support",
                    icons: Ionicons.chatbubble_outline),
                const SizedBox(height: 10),
                ItemDrawerMenu(
                    size: size,
                    title: "Log Out",
                    icons: Ionicons.log_out_outline),
                const SizedBox(height: 20),
                const Text(
                  "Send Money",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: mediumGreyColor),
                ),
                const SizedBox(height: 15),
                ItemDrawerSendMoney(size: size, title: "Artem Sazonov"),
                const SizedBox(height: 10),
                ItemDrawerSendMoney(size: size, title: "Sophie Asveld"),
                const SizedBox(height: 10),
                ItemDrawerSendMoney(size: size, title: "Kobus van de Vegte"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
