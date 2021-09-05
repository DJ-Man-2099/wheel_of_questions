import 'package:flutter/material.dart';
import 'package:wheel_of_questions/Item.dart';
import 'Question.dart';
import 'questions.dart';
import 'wheel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'فقرة الاسئلة',
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('فقرة الاسئلة', style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              width: double.infinity,
              height: double.infinity,
              child: MainWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({
    Key? key,
  }) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  var isShown = false;
  var current;
  var cItems = items.toList();
  var team = 0;

  void onChange(Map index) {
    current = index;
    if (index['isQuestion']) {
      setState(() {
        isShown = true;
      });
    } else {
      var text = index['text'] == 'نقط ببلاش' ? 'مبروووووووك' : 'يا خسارة';
      var subtext = index['text'] == 'نقط ببلاش'
          ? 'كسبت معانا نقطة ببلاش'
          : 'للأسف مكسبتش ولا نقطة';
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              text,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            content: Text(
              subtext,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                    cItems.remove(current);
                    isShown = false;
                    if (cItems.length == 1) {
                      onChange(cItems[0]);
                    }
                  });
                },
                child: Text(
                  'يلا نكمل',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          );
        },
      );
    }
  }

  void onSubmit() {
    var text = Questions[int.parse(current['text']) - 1].isCorrect
        ? "عاش يا بطل"
        : 'للأسف غلط';

    var subtext =
        'الاجابة الصح هي ${Questions[int.parse(current['text']) - 1].correct.join(', ')}';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            subtext,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: Text(
            text,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                  cItems.remove(current);
                  isShown = false;
                  if (cItems.length == 1) {
                    onChange(cItems[0]);
                  }
                  /* else if (cItems.length == 0) {
                    print('resetting');
                    items.forEach((element) {
                      cItems.add(element);
                    });
                  } */
                });
              },
              child: Text(
                'يلا نكمل',
                textDirection: TextDirection.rtl,
              ),
            )
          ],
        );
      },
    );
  }

  void onSwitch(int index){
    setState(() {
      team = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Wheel(
          onChange: onChange,
          items: cItems,
          reset: () {
            print(items);
            setState(() {
              items.forEach((element) {
                print(element);
                cItems.add(element);
              });
            });
          },
        ),
        //TeamSwitch(index: team, onSelect: onSwitch,),
        QuestionWidget(
          isShown: isShown,
          question: isShown ? Questions[int.parse(current['text']) - 1] : null,
          onSubmit: onSubmit,
        ),
      ],
    );
  }
}
