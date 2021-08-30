import 'package:flutter/material.dart';
import 'package:wheel_of_questions/GradientButton.dart';
import 'package:wheel_of_questions/Question%20Holder/Question.dart';
import 'package:wheel_of_questions/QuestionHolder.dart';

class QuestionWidget extends StatelessWidget {
  final bool isShown;
  late final Question? question;
  late final void Function() onSubmit;

  QuestionWidget(
      {Key? key, this.isShown = false, this.question, required this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      child: !isShown
          ? Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(
                  color: Colors.red,
                  style: BorderStyle.solid,
                  width: 10,
                ),
              ),
              child: Center(
                child: Text(
                  "مستنيين السؤال",
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 50),
                ),
              ),
            )
          : Column(
              children: [
                QuestionHolder(
                  question: this.question as Question,
                ),
                GradientButton(
                    onPressed: onSubmit,
                    child: Text(
                      "انا متأكد",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ))
              ],
            ),
    );
  }
}
