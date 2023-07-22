import 'package:flutter/material.dart';
import 'package:frond_end_rental/widget/appbar_custom.dart';

var amount = "IDR. 30.000";
var paket = "Package City Tour";

class TransactionVerification extends StatelessWidget {
  const TransactionVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarCustom("Transaction Verification", null),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.width * 0.05,
          ),
          Container(
            margin: const EdgeInsets.all(2),
            child: const Text(
              "Amount",
              style: TextStyle(fontSize: 10),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Text(
              amount,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: const Text(
              "Upload Bukti",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 250,
            height: 250,
            color: Colors.white,
            child: Container(
              width: 230,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 230,
              margin: const EdgeInsets.all(20),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: const Text(
              "Total Transaction",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your $paket ",
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                amount,
                style: const TextStyle(color: Colors.blue),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: const Text(
              "Are you sure",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(
                    size.width * 0.02,
                  ),
                  child: SizedBox(
                    width: size.width * 0.45,
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                        foregroundColor: MaterialStatePropertyAll(Colors.black),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(size.width * 0.02),
                  child: SizedBox(
                    width: size.width * 0.45,
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Confirm"),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
