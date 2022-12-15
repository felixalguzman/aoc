import 'package:aoc/extensions.dart';
import 'package:aoc/models.dart';

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
  final T value;
  int level;
  final List<TreeNode<T>> children = <TreeNode<T>>[];

  TreeNode(this.value, [this.level = 1]);

  void add(TreeNode<T> child) {
    // print('current: $runtimeType el que viene: ${child.runtimeType}');
    children.add(child);
  }

  bool addToNode(TreeNode<T> old, TreeNode<T> toUpdate) {
    if (this == old) {
      add(toUpdate);
      return true;
    }

    for (final child in children) {
      final added = child.addToNode(old, toUpdate);
      if (added) {
        return true;
      }
    }

    return false;
  }

  Iterable<TreeNode<T>> forEachDepthFirst(
      bool Function(TreeNode<T> node) performAction) sync* {
    final apply = performAction(this);
    if (apply) {
      yield this;
    }

    for (final child in children) {
      final added = child.forEachDepthFirst(performAction);
      for (var element in added) {
        yield element;
      }
    }
  }

  TreeNode<T>? findNode(bool Function(TreeNode<T> node) query) {
    final search = query(this);
    if (search) {
      return this;
    }

    for (final child in children) {
      final last = child.findNode(query);
      if (last != null) {
        return last;
      }
    }

    return null;
  }

  void printTree() {
    print('${'\t' * level} Nodo: ${value?.toString()}');
    if (children.isNotEmpty) {
      print(
          '${'\t' * level} Nivel $level ${(this as TreeNode<FileSystem>).folderSize}');
    }

    for (var child in children) {
      child.printTree();
    }
  }
}
