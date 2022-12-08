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
}
