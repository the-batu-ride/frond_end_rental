import 'package:flutter/material.dart';

class appbarCustom extends AppBar{
  appbarCustom(String data):super(
   
    title: Text(data),
    centerTitle: true,
    actions: [

      IconButton(onPressed: (){}, icon: const Icon(Icons.notifications) ),
  
    ],
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back)),
  );
}