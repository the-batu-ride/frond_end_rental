import 'package:flutter/material.dart';
import 'package:frond_end_rental/widget/appbar_custom.dart';

var status = true;
var name = "khamal akbar";
var bankname = "Envanto Bank";
var transactionkategori = "Shopping";
var receipt = "true";
var date = "sep 25, 2020 10:45 AM";
var amount = "24";

class TransactionDetail extends StatelessWidget {
  const TransactionDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarCustom("Transaction Detail", Icons.delete, context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: size.height * 0.10,
              height: size.height * 0.10,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(size.height * 0.10),
                ),
              ),
              child: const Icon(Icons.arrow_right_alt, color: Colors.white),
            ),
            const Text(
              "payment sent",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.all(size.height * 0.10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Status"),
                      status == true
                          ? const Text(
                              "Success",
                              style: TextStyle(color: Colors.green),
                            )
                          : const Text(
                              "Failed",
                              style: TextStyle(color: Colors.green),
                            )
                    ],
                  ),
                  renderDevider(Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("To"), Text(name)],
                  ),
                  renderDevider(Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Bank Name"), Text(bankname)],
                  ),
                  renderDevider(Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Transaction Catagory"),
                      Text(transactionkategori)
                    ],
                  ),
                  renderDevider(Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Receipt"),
                      receipt == true ? Text("yes") : Text("no")
                    ],
                  ),
                  renderDevider(Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Date"), Text(date)],
                  ),
                  renderDevider(Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount"),
                      Text(
                        amount,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  renderDevider(Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderDevider(Color color) {
    return Divider(
      color: color,
      height: 20,
    );
  }
}
