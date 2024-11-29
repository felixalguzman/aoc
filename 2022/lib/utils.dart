class Stack<E> {
  Stack() : _items = <E>[];

  Stack.of(Iterable<E> elements) : _items = List<E>.of(elements);

  Stack.clone(Stack<E> old) : _items = List.of(old._items);

  final List<E> _items;

  void push(E element) => _items.add(element);

  E pop() => _items.removeLast();

  E get peek => _items.last;

  bool get isEmpty => _items.isEmpty;

  bool get isNotEmpty => !isEmpty;

  void reverse() {
    final reverse = _items.reversed.toList();
    _items.clear();
    _items.addAll(reverse);
  }

  void clear() => _items.clear();

  @override
  String toString() {
    return '--- Top ---\n'
        '${_items.reversed.join('\n')}'
        '\n-----------';
  }
}
