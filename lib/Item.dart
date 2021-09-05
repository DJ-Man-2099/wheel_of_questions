import 'package:flutter/material.dart';

final half1 = [1, 2, 3, 4, 5, 6, 7, 8];

final List<Map<String, dynamic>> items = [
  ...(half1
      .map((e) => {
            'text': e.toString(),
            "color": Color((e.toString().hashCode * 0xFFFFFF).toInt()),
            'turns': 1,
            'isQuestion': true,
          })
      .toList()),
  {
    'text': 'نقط ببلاش',
    "color": Colors.yellow.shade300,
    'turns': 0,
    'isQuestion': false,
  },
  ...(half1
      .map((e) => {
            'text': (e + 8).toString(),
            "color": Color(((e + 8).toString().hashCode * 0xFFFFFF).toInt()),
            'turns': 1,
            'isQuestion': true,
          })
      .toList()),
];

