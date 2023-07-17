import 'package:flutter/material.dart';

class footerCustom extends Container{
  footerCustom():super(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.circle)),
            Text("Overview")
          ],
        ),
         Column(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.newspaper)),
            Text("Berita")
          ],
        ),
         Column(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.qr_code)),
            Text("Scan QR")
          ],
        ),
         Column(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
            Text("Notifikasi")
          ],
        ),
         Column(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.settings)),
            Text("Setting")
          ],
        )
      ],
    )
  );
}