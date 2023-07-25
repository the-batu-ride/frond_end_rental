import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/utils/format_rupiah.dart';

Widget cardListTransaksi(
  BuildContext context, {
  required Size size,
  required String nameTransaksi,
  required String price,
  required String status,
  required dynamic package,
  required dynamic data,
}) {
  return Builder(builder: (context) {
    return GestureDetector(
      onTap: () async {
        final id = data['id'];

        if (status == "APPROVED") {
          setCurrentNavigation(id).then((_) {
            Navigator.of(context).pushNamed('/map');
          });
          return;
        }

        if (status == "COMPLETED") {
          setCurrentDetail(id).then((_) {
            Navigator.of(context).pushNamed('/detail-transaction');
          });
          return;
        }

        if (status == "PENDING") {
          setCurrentPayment(id).then((_) {
            Navigator.of(context).pushNamed('/verification');
          });
          return;
        }
      },
      child: Column(
        children: [
          const SizedBox(
            height: 4,
          ),
          Container(
            padding: const EdgeInsets.all(17),
            width: size.width * 1,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * .50,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: Image.asset(
                          './assets/images/1.jpg',
                          width: 40,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nameTransaksi,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              formatRupiah(double.parse(price)),
                              style: const TextStyle(color: mediumGreyColor),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        status.toLowerCase(),
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formatRupiah(double.parse(price)),
                        style: const TextStyle(
                          color: pinkEvent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  });
}
