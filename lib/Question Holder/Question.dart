class _Answers {
  final String text;
  final int index;
  bool _isSelected = false;

  _Answers({required this.text, required this.index});

  @override
  String toString() {
    return this.text;
  }

  void select() {
    _isSelected = true;
  }

  void unSelect() {
    _isSelected = false;
  }

  bool get isSelected {
    return _isSelected;
  }
}

enum questionTypes {
  Choose,
  MultipleChoice,
  TrueOrFalse,
}

class Question {
  final String text;
  late List<_Answers> _answers;
  late List<int> _correct;
  late questionTypes type;
  num _score = 0;

  Question(
      {required this.text,
      num score = 0,
      List<String>? answers,
      List<int>? correct,
      bool isMultiple = true}) {
    _answers = answers
            ?.asMap()
            .map((index, text) =>
                MapEntry(index, _Answers(text: text, index: index)))
            .values
            .toList() ??
        [];
    _score = score;
    _correct = correct ?? [];
    type = isMultiple ? questionTypes.MultipleChoice : questionTypes.Choose;
  }

  Question.asTrueFalse({
    required this.text,
    int correct = 0,
    num score = 0,
  }) {
    _answers = [
      _Answers(text: 'True', index: 0),
      _Answers(text: 'False', index: 1)
    ];
    _correct = [correct];
    type = questionTypes.TrueOrFalse;
    _score = score;
  }

  @override
  String toString() {
    var answers = '';
    for (var i = 0; i < _answers.length - 1; i++) {
      answers += _answers[i].toString() + ',';
    }
    answers += _answers.last.toString();
    return 'Question: $text\nAnswers: $answers';
  }

  void addAnswer(String text) {
    _answers.add(_Answers(text: text, index: _answers.length));
  }

  void addCorrectAnswer(int answer) {
    switch (this.type) {
      case questionTypes.MultipleChoice:
        _correct.add(answer);
        break;
      default:
        _correct = [answer];
        break;
    }
  }

  List<_Answers> get answers {
    return _answers;
  }

  int get length {
    return _answers.length;
  }

  List<String> get correct {
    var co = <String>[];
    for (var i in _correct) {
      co.add(_answers[i].text);
    }
    return co;
  }

  void reset() {
    for (var a in _answers) {
      a.unSelect();
    }
  }

  List get chosenAnswers {
    return _answers
        .where((element) => element.isSelected)
        .toList()
        .map((e) => e.index)
        .toList();
  }

  num get score {
    if (this.isCorrect) {
      return this._score;
    } else {
      if (this.type == questionTypes.MultipleChoice) {
        var l = this.chosenAnswers.length;
        var c = this.correct.length;
        if (l < c) {
          return this._score / c * l;
        } else {
          return this._score * (1 - 1 / c * (l - c));
        }
      } else {
        return 0;
      }
    }
  }

  num get total {
    return this._score;
  }

  bool get isCorrect {
    var answers = this.chosenAnswers;
    if (answers.length != _correct.length) {
      return false;
    }
    for (var ans in _correct) {
      if (!answers.contains(ans)) {
        return false;
      }
    }
    return true;
  }
}
