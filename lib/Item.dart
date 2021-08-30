import 'package:flutter/material.dart';

final half1 = [1, 2, 3, 4, 5, 6, 7];

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
    "color": Color(0xFF123456),
    'turns': 0,
    'isQuestion': false,
  },
  ...(half1
      .map((e) => {
            'text': (e + 7).toString(),
            "color": Color(((e + 7).toString().hashCode * 0xFFFFFF).toInt()),
            'turns': 1,
            'isQuestion': true,
          })
      .toList()),
  {
    'text': 'من غير نقط',
    "color": Colors.red,
    'turns': 0,
    'isQuestion': false,
  },
];
