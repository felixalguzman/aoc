import 'package:aoc/aoc.dart';

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

  /// A X - Rock
  /// B Y - Paper
  /// C Z - Scissor
  String mapRockPaperScissor(String other, [bool toWin = true]) {
    switch (other) {
      case 'A':
        return !toWin ? 'Z' : 'Y';
      case 'B':
        return !toWin ? 'X' : 'Z';
      case 'C':
        return !toWin ? 'Y' : 'X';
      default:
        return '';
    }
  }

  ///Get the next char
  String get nextChar => String.fromCharCode(codeUnitAt(0) + 1);

  String findCharToWin(String opponent) => mapRockPaperScissor(opponent);

  String findCharToLoose(String opponent) =>
      mapRockPaperScissor(opponent, false);

  Dic countChars(String other) {
    final map = <String, int>{};

    final firstRunes = runes.map((e) => e).toList();
    final secondRunes = other.runes.map((e) => e).toList();

    firstRunes.retainWhere((element) => secondRunes.contains(element));

    for (final rune in firstRunes) {
      map.update(
        String.fromCharCode(rune),
        (old) => old++,
        ifAbsent: () => 1,
      );
    }

    return map;
  }

  bool get isLowerCase =>
      runes.isNotEmpty &&
      runes.first >= 97 &&
      runes.first <= 122;
}
