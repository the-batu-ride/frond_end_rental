import 'package:flutter/material.dart';
import 'package:frond_end_rental/widget/appbar_custom.dart';
import 'package:frond_end_rental/widget/footer_custom.dart';

var amount = "IDR. 30.000";
var paket = "Package City Tour";

class transactionVertification extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appbarCustom("Transaction Verification", null),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.05,
          ),
          Container(
              margin: EdgeInsets.all(2),
              child: Text(
                "Amount",
                style: TextStyle(fontSize: 10),
              )),
          Container(
              margin: EdgeInsets.all(5),
              child: Text(
                amount,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Container(
              margin: EdgeInsets.all(5),
              child: Text(
                "Upload Bukti",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Container(
            width: 250,
            height: 250,
            color: Colors.white,
            child: Container(
              width: 230,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: 230,
              margin: EdgeInsets.all(20),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "Total Transaction",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Your " + paket + " ",
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              amount,
              style: TextStyle(color: Colors.blue),
            )
          ]),
          Container(
              margin: EdgeInsets.all(5),
              child: Text(
                "Are you sure",
                style: TextStyle(color: Colors.grey),
              )),
          Positioned(
            bottom: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.02),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Cancel"),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white),
                              foregroundColor:
                                  MaterialStatePropertyAll(Colors.black)),
                        ))),
                Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("Confirm"))),
                ),
              ],
            ),
          )
        ]),
      );
}
