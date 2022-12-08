extension ListExtensions on List<int> {
  int get sum => isEmpty ? 0 : reduce((value, element) => value + element);
}
