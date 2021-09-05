import 'package:flutter/material.dart';
import 'package:wheel_of_questions/numButton.dart';

class TeamSwitch extends StatelessWidget {

  final int index;
  final void Function(int) onSelect;

  const TeamSwitch({ Key? key,required this.onSelect,required this.index }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List <Widget> Buttons = [];  

    for (var i = 0; i < 4; i++) {
      Buttons.add(
        NumButton(index: i, onSelect: ()=>onSelect(i), current: index)
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 50
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: Buttons,
          ),
        )
      ],
    );
  }
}