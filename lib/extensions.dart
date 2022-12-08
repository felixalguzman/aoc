extension ListExtensions on List<int> {
  int get sum => isEmpty ? 0 : reduce((value, element) => value + element);
}

extension StringExtensions on String {
  int paperScissorPoint() {
    switch (this) {
      case 'A':
      case 'X':
        return 1;
      case 'B':
      case 'Y':
        return 2;
      case 'C':
      case 'Z':
        return 3;

      default:
        return 0;
    }
  }

  /// A X - Rock
  /// B Y - Paper
  /// C Z - Scissor
  bool rockPaperScissor(String other, [bool toWin = true]) {
    switch (this) {
      case 'A':
        return toWin
            ? other == 'Z'
            : other == 'Y'
                ? true
                : false;
      case 'B':
        return toWin
            ? other == 'X'
            : other == 'Z'
                ? true
                : false;
      case 'C':
        return toWin
            ? other == 'Y'
            : other == 'X'
                ? true
                : false;

      default:
        return false;
    }
  }

  ///Get the next char
  String get nextChar => String.fromCharCode(codeUnitAt(0) + 1);

  String findCharToWin(String opponent) {
    var won = false;
    var char = 'X';
    while (!won) {
      final win = !opponent.rockPaperScissor(char);
      if (win && char != this) {
        won = true;
        // char = 'X';
      } else {
        char = char.nextChar;
      }
    }

    return char;
  }

  String findCharToLoose(String opponent) {
    var won = true;
    var char = 'X';
    while (!won) {
      final win = !opponent.rockPaperScissor(char, false);
      if (win && char != this) {
        won = true;
        // char = 'X';

      } else {
        char = char.nextChar;
      }
    }

    return char;
  }
}
