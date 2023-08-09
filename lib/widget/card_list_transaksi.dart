import 'package:flutter/material.dart';
import 'package:frond_end_rental/constant/colors.dart';
import 'package:frond_end_rental/models/transaction.dart';
import 'package:frond_end_rental/utils/format.dart';
import 'package:frond_end_rental/utils/security.dart';
import 'package:go_router/go_router.dart';

class CardHistory extends StatelessWidget {
  final Transaction data;
  final Size size;

  const CardHistory({
    super.key,
    required this.data,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleSelected(context),
      child: Column(
        children: [
          const SizedBox(
            height: 4,
          ),
          Container(
            padding: const EdgeInsets.all(17),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
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
                              data.package.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              formatRupiah(double.parse(data.package.price)),
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
                        data.status.toLowerCase(),
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formatRupiah(double.parse(data.package.price)),
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
  }

  void handleSelected(BuildContext context) {
    final id = encryptId(data.id);

    if (data.isApproved) {
      context.goNamed('route', pathParameters: {'code': id});
    }
    if (data.isPending) {
      context.goNamed('verification', pathParameters: {'code': id});
    }
    if (data.isCompleted || data.isRejected) {
      context.goNamed('detail', pathParameters: {'code': id});
    }
  }
}
