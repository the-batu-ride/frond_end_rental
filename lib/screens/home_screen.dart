import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frond_end_rental/bloc/auth/auth_bloc.dart'
    show AuthBloc, AuthChecking, CheckStatus, AuthState, SignedIn;
import 'package:frond_end_rental/models/auth.dart';

import 'package:frond_end_rental/widget/items.dart';
import 'package:frond_end_rental/widget/route_bottom_sheet.dart';
import 'package:ionicons/ionicons.dart';

import '../constant/colors.dart';
import '../widget/bottom_menu.dart';
import '../widget/card_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>()
      ..add(AuthChecking())
      ..add(CheckStatus());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: const Icon(
          Icons.menu,
          color: primaryColor,
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
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, top: 8.0, bottom: 8.0, right: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.asset(
                './assets/images/1.jpg',
                width: 30,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is SignedIn) {
            return HomeWidget(
              size: size,
              data: state.authEntity,
            );
          }

          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        },
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.size,
    required this.data,
  });

  final Size size;
  final AuthEntity data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
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
                FeatureBars(size: size, data: data),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 30.0,
                right: 20,
                left: 20,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Berita Terbaru',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: mediumGreyColor,
                    ),
                  ),
                ],
              ),
            ),
            const EventsWidget(),
          ],
        ),
      ),
    );
  }
}

class FeatureBars extends StatelessWidget {
  const FeatureBars({
    super.key,
    required this.size,
    required this.data,
  });

  final Size size;
  final AuthEntity data;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Container(
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
                padding: const EdgeInsets.symmetric(horizontal: 25),
                alignment: Alignment.centerLeft,
                width: size.width * 0.85,
                height: size.height * 0.11,
                child: Text(
                  'Selamat Datang ${data.name}',
                  style: const TextStyle(
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
                  top: 10,
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Builder(builder: (context) {
                      return renderItemDashboard(
                        size: size,
                        title: 'Package Route',
                        color: yellowBicycle,
                        icons: Ionicons.bicycle_outline,
                        handleClick: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => const PakcageBottomSheet(),
                          );
                        },
                      );
                    }),
                    renderItemDashboard(
                      size: size,
                      title: 'Saldo',
                      color: greenSaldo,
                      icons: Ionicons.file_tray_outline,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventsWidget extends StatelessWidget {
  const EventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CardEvent(
              image: './assets/images/4.jpg',
              title: 'Event Bromo KOM Challenge 2023',
            ),
            CardEvent(
              image: './assets/images/4.jpg',
              title: 'Banyuwangi Blue Fire Ijen Challenge 2023',
            ),
            CardEvent(
              image: './assets/images/4.jpg',
              title: 'Kediri Dholo KOM Challenge 2023',
            ),
          ],
        ),
      ),
    );
  }
}
