class Stack<E> {
  Stack() : _items = <E>[];

  Stack.of(Iterable<E> elements) : _items = List<E>.of(elements);

  final List<E> _items;

  void push(E element) => _items.add(element);

  E pop() => _items.removeLast();

  E get peek => _items.last;

  bool get isEmpty => _items.isEmpty;

  bool get isNotEmpty => !isEmpty;

  @override
  String toString() {
    return '--- Top ---\n'
        '${_items.reversed.join('\n')}'
        '\n-----------';
  }
}
