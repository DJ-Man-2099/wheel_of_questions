import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:wheel_of_questions/GradientButton.dart';

class Wheel extends StatefulWidget {
  final void Function(Map) onChange;
  final List<Map<String, dynamic>> items;
  final void Function() reset;

  Wheel({
    Key? key,
    required this.onChange,
    required this.items,
    required this.reset,
  }) : super(key: key);

  @override
  _WheelState createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  StreamController<int> controller = StreamController<int>();
  late List<Map<String, dynamic>> tItems;
  var choice = 0;

  @override
  void initState() {
    super.initState();
    tItems = widget.items;
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: tItems.length > 1
                  ? FortuneWheel(
                      onAnimationEnd: () {
                        widget.onChange(tItems[choice]);
                      },
                      animateFirst: false,
                      selected: controller.stream,
                      items: [
                        for (var it in tItems)
                          FortuneItem(
                            style: FortuneItemStyle(
                              textAlign: TextAlign.center,
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              color: it['color'],
                            ),
                            child: RotatedBox(
                              quarterTurns: it['turns'],
                              child: Text(
                                it['text'],
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ),
                      ],
                    )
                  : tItems.length == 1
                      ? ClipRRect(
                          child: Container(
                            child: Center(
                              child: Text(
                                tItems[0]['text'],
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: tItems[0]['color'],
                            ),
                          ),
                        )
                      : ClipRRect(
                          child: Container(
                            child: Center(
                              child: Text(
                                'مفيش اسئلة خلاص',
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                          ),
                        ),
            ),
          ),
          GradientButton(
            onPressed: () {
              if (tItems.length > 1) {
                choice = Fortune.randomInt(0, tItems.length);
                controller.add(choice);
              } else if (tItems.length == 0) {
                controller.close();
                widget.reset();
                controller = StreamController<int>();
              }
            },
            child: Text(
              tItems.length > 0 ? 'لف العجلة' : 'عيد من الأول',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
