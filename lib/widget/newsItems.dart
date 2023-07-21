import 'package:flutter/material.dart';

Widget renderNewsItem({
  required Image image,
  required String title,
}) {
  return GestureDetector(
    onTap: () {},
    child: Card(
      width: 200,
      heightImage: 140,
      imageProvider: AssetImage('assets/mockup.png'),
      tags: [_tag('Category', () {}), _tag('Product', () {})],
      title: _title(),
      description: _content(),
    ),
  );
}
