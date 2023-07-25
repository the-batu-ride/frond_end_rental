import 'package:flutter/material.dart';
import 'package:frond_end_rental/utils/security.dart';
import 'package:frond_end_rental/widget/appbar_custom.dart';
import 'package:frond_end_rental/widget/bottom_menu.dart';
import 'package:dio/dio.dart';
import 'package:frond_end_rental/constant/conection.dart';
import 'package:frond_end_rental/provider/transaction_provider.dart';
import 'package:frond_end_rental/widget/route_bottom_sheet.dart';
import 'package:provider/provider.dart';

var status = true;
var name = "khamal akbar";
var bankname = "Envanto Bank";
var transactionkategori = "Shopping";
var receipt = "true";
var date = "sep 25, 2020 10:45 AM";
var amount = "\$24";

class TransactionDetail extends StatelessWidget {
  const TransactionDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
SizedBox marginItem(){
  return SizedBox(
    height: size.height *0.02,
  );
}
    return Scaffold(
      
      appBar: AppBarCustom("Transaction Detail", Icons.delete, context),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
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
                "Payment Sent",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Container(
                margin: EdgeInsets.only(left: size.height * 0.10,right: size.height * 0.10,top:  size.height * 0.05),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Status",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),
                        status == true
                            ? const Text(
                                "Success",
                                style: TextStyle(color: Colors.green ,fontSize: 16),
                              )
                            : const Text(
                                "Failed",
                                style: TextStyle(color: Colors.green ,fontSize: 16),
                              )
                      ],
                    ),
                    renderDevider(Colors.grey,)

                    
                    ,
                     marginItem(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text("To",style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 16)), Text(name ,style: TextStyle(fontSize: 16),)],
                    ),
                    renderDevider(Colors.grey),
                    marginItem(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text("Bank Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)), Text(bankname,style: TextStyle(fontSize: 16))],
                    ),
                    renderDevider(Colors.grey),
                     marginItem(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Transaction Catagory",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        Text(transactionkategori)
                      ],
                    ),
                    renderDevider(Colors.grey),
                     marginItem(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Receipt",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        receipt == true ? const Text("yes") : const Text("no")
                      ],
                    ),
                    renderDevider(Colors.grey),
                     marginItem(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text("Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)), Text(date)],
                    ),
                    renderDevider(Colors.grey),
                     marginItem(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Amount",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        Text(
                          amount,
                          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                        )
                      ],
                    ),
                 
                  ],
                ),
              ),
            
            ],
          ),
        ),
      ),
         bottomNavigationBar: bottomMenu(
        onQrResolve: (dataQr) async {
          final newId = dataQr!.replaceFirst(RegExp('Code scanned = '), '');
          final id = encryptId(int.parse(newId));

          final token = await getToken();
          final response = await client.get(
            '${apiConnection}api/v1/bike/$id',
            options: Options(headers: {'Authorization': 'Bearer $token'}),
          );

          if (context.mounted) {
            context
                .read<TransactionProvider>()
                .setBike(response.data['data']['id']);

            showModalBottomSheet(
              context: context,
              builder: (ctx) => const PakcageBottomSheet(),
            );
          }
        },
        toTrans: () {
          Navigator.of(context).pushNamed('/history');
        },
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
