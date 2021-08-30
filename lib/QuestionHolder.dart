import 'package:flutter/material.dart';
import '../GradientButton.dart';
import './Question Holder/Question.dart';

class QuestionHolder extends StatefulWidget {
  static void _defaultFunction() {
    print('do Nothing');
  }

  const QuestionHolder(
      {Key? key, required this.question, this.onChange = _defaultFunction})
      : super(key: key);

  final Question question;
  final void Function() onChange;

  @override
  _QuestionHolderState createState() => _QuestionHolderState();
}

class _QuestionHolderState extends State<QuestionHolder> {
  void onSelect(int index) {
    this.setState(() {
      if (widget.question.answers[index].isSelected == true) {
        widget.question.answers[index].unSelect();
      } else {
        if (widget.question.type == questionTypes.MultipleChoice) {
          widget.question.answers[index].select();
        } else {
          for (int i = 0; i < widget.question.length; i++) {
            if (widget.question.answers[i].index == index) {
              widget.question.answers[i].select();
            } else {
              widget.question.answers[i].unSelect();
            }
          }
        }
      }
      widget.onChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      color:
          Color((widget.question.hashCode * 0xFFFFFF).toInt()).withOpacity(1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            alignment: Alignment.center,
            child: Text(
              widget.question.text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              alignment: Alignment.center,
              height: 225,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  //Add here the asnwers
                  var answer = widget.question.answers[i];
                  return AnswerHolder(
                      answer: answer, onSelect: () => onSelect(i));
                },
                itemCount: widget.question.length,
              )),
        ],
      ),
    );
  }
}

class AnswerHolder extends StatelessWidget {
  const AnswerHolder({Key? key, required this.answer, required this.onSelect})
      : super(key: key);

  final answer;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10.0,
              ),
              child: GradientButton(
                gradient: !answer.isSelected
                    ? LinearGradient(colors: [Colors.red, Colors.blue])
                    : LinearGradient(
                        colors: [Colors.greenAccent.shade400, Colors.yellow]),
                splashColor: !answer.isSelected
                    ? Colors.greenAccent.shade400
                    : Colors.blue,
                child: Text(
                  answer.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                onPressed: onSelect,
              )),
        ),
      ],
    );
  }
}
