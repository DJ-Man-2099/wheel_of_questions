import 'package:flutter/material.dart';

class NumButton extends StatelessWidget {
  final int index, current;
  final void Function() onSelect;

  const NumButton(
      {Key? key,
      required this.index,
      required this.onSelect,
      required this.current})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: index == current ? 56 : 50,
        width: index == current ? 56 : 50,
        decoration: BoxDecoration(
            border: Border.all(
          color: index == current ? Colors.blue.shade300 : Colors.grey.shade600,
          style: BorderStyle.solid,
          width: index==current? 5: 2,
        ),
        borderRadius: BorderRadius.circular(10)
        ),
        child: InkWell(
          onTap: onSelect,
          child: Center(
            child: Text((index + 1).toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color:  index == current ? Colors.blue.shade300 : Colors.grey.shade600,
              fontSize:  index == current ? 30 : 25,
              fontWeight:  index == current ? FontWeight.bold : FontWeight.normal,
            ),),
          ),
        ),
      ),
    );
  }
}
