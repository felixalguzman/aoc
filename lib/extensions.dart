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
  bool rockPaperScissorWon(String other) {
    switch (this) {
      case 'A':
        return other == 'Z' ? true : false;
      case 'B':
        return other == 'X' ? true : false;
      case 'C':
        return other == 'Y' ? true : false;

      default:
        return false;
    }
  }
}
