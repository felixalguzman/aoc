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

class TreeNode<T> {
  T? value;
  final TreeNode<T>? parent;
  final List<T> children;

  TreeNode([this.value, this.parent, this.children = const []]);

  void add(T child) {
    children.add(child);
  }

  void setValue(T val) {
    value = val;
  }

  // void forEachDepthFirst(void Function(T node) performAction) {
  //   performAction(this);
  //   for (final child in children) {
  //     child.forEachDepthFirst(performAction);
  //   }
  // }
}
