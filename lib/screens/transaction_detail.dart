import 'package:flutter/material.dart';
import 'package:frond_end_rental/widget/appbar_custom.dart';

var status = true;
var name = "khamal akbar";
var bankname = "Envanto Bank";
var transactionkategori = "Shopping";
var receipt = "true";
var date = "sep 25, 2020 10:45 AM";
var amount = "24";

class transactionDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: appbarCustom("Transaction Detail", Icons.delete),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.height * 0.10,
                height: MediaQuery.of(context).size.height * 0.10,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(
                        MediaQuery.of(context).size.height * 0.10))),
                child: Icon(Icons.arrow_right_alt, color: Colors.white),
              ),
              Text(
                "payment sent",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Status"),
                          status == true
                              ? Text(
                                  "Success",
                                  style: TextStyle(color: Colors.green),
                                )
                              : Text("Failed",
                                  style: TextStyle(color: Colors.green))
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("To"), Text(name)],
                      ),
                      Divider(
                        color: Colors.black,
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Bank Name"), Text(bankname)],
                      ),
                      Divider(
                        color: Colors.black,
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Transaction Catagory"),
                          Text(transactionkategori)
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Receipt"),
                          receipt == true ? Text("yes") : Text("no")
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Date"), Text(date)],
                      ),
                      Divider(
                        color: Colors.black,
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Amount"),
                          Text(amount,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                        height: 20,
                      ),
                    ],
                  )),
            ],
          )));
}
