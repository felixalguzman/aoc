import 'dart:io';
import 'package:aoc/extensions.dart';
import 'package:aoc/models.dart';
import 'package:aoc/utils.dart';

int calculate() {
  return 6 * 7;
}

void resolve(int day, [int year = 2022]) {
  switch (day) {
    case 1:
      day12022();
      break;
    case 2:
      day22022();
      break;
    case 3:
      day32022();
      break;
    case 4:
      day42022();
      break;
    case 5:
      day52022();
      break;
    case 6:
      day62022();
      break;
    case 7:
      day72022();
      break;
    default:
  }
}

void day12022() {
  final fileContent = File('./assets/sources/2022/1.txt').readAsStringSync();

  var currentElf = 0;
  final elfs = <int, List<int>>{};
  final lines = fileContent.split('\n');
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    if (line.isNotEmpty && line.length > 1) {
      final parse = int.parse(line);
      if (elfs[currentElf] != null) {
        elfs[currentElf]!.add(parse);
      } else {
        elfs[currentElf] = [parse];
      }
    } else {
      currentElf++;
    }
  }

  final sorted = elfs.entries.toList();
  sorted.sort((a, b) => a.value.sum.compareTo(b.value.sum));

  final top3 = sorted.reversed.take(3);
  for (final element in top3) {
    print('Elfo ${element.key} cal: ${element.value.sum}');
  }

  final total = top3.map((e) => e.value.sum).toList().sum;
  print('Total: $total');
}

void day22022() {
  final fileContent = File('./assets/sources/2022/2.txt').readAsStringSync();

  final playerGuide = <StrategyGuide>[];
  final secondPlayerGuide = <StrategyGuide>[];
  final lines = fileContent.split('\n');
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    if (line.isEmpty || line.length <= 1) {
      continue;
    }

    final moves = line.split(' ');

    final oppMove = moves[0].paperScissorPoint();
    final playerMove = moves[1].trim().paperScissorPoint();

    final won = oppMove == playerMove
        ? false
        : !moves[0].rockPaperScissor(moves[1].trim());

    final roundPoints = won ? 6 : (oppMove == playerMove ? 3 : 0);
    playerGuide.add(
        StrategyGuide(round: i, won: won, points: roundPoints + playerMove));

    switch (playerMove) {
      case 1:
        final toLoose = moves[1]
            .trim()
            .findCharToLoose(moves[0].trim())
            .paperScissorPoint();

        secondPlayerGuide
            .add(StrategyGuide(round: i, won: won, points: 0 + toLoose));

        break;
      case 2:
        secondPlayerGuide
            .add(StrategyGuide(round: i, won: won, points: 3 + oppMove));

        break;
      case 3:
        final toWin =
            moves[1].trim().findCharToWin(moves[0].trim()).paperScissorPoint();
        secondPlayerGuide
            .add(StrategyGuide(round: i, won: won, points: 6 + toWin));

        break;
      default:
        continue;
    }
  }

  final playerPoints = playerGuide.map((e) => e.points).toList();
  print('Part 1');
  print('Player points: ${playerPoints.sum} ');
  print('Part 2');
  final secondPlayerPoints = secondPlayerGuide.map((e) => e.points).toList();
  print('Player points: ${secondPlayerPoints.sum} ');
}

typedef Dic = Map<String, int>;
void day32022() {
  final fileContent = File('./assets/sources/2022/3.txt').readAsStringSync();

  final lines = fileContent.split('\n');
  final itemTypes = <Dic>[];
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i].trim();
    final half = line.length ~/ 2;
    final firstPart = line.substring(0, half);
    final secondPart = line.substring(half);

    final countChars = firstPart.countChars(secondPart);
    final copy = Map<String, int>.from(countChars);
    countChars.forEach((key, value) {
      final pointDiff = key.isLowerCase ? 96 : 38;
      final points = key.codeUnitAt(0) - pointDiff;
      copy.update('points', (value) => value + points, ifAbsent: () => points);
    });

    itemTypes.add(copy);
  }
  final firstPartTotal = itemTypes.map((e) => e['points'] ?? 0).toList().sum;
  print('Total part 1: $firstPartTotal');

  itemTypes.clear();
  for (var i = 0; i < lines.length; i += 3) {
    final parts = lines.skip(i).map((e) => e.trim()).take(3).toList();

    final copy = <String, int>{};
    if (parts.length == 3) {
      final first = parts.first;
      final second = parts[1];
      final third = parts.last;

      final result = [first, second, third]
          .map((e) => e.codeUnits)
          .expand((element) => element)
          .toSet()
          .toList();

      result.retainWhere((element) => first.codeUnits.contains(element));
      result.retainWhere((element) => second.codeUnits.contains(element));
      result.retainWhere((element) => third.codeUnits.contains(element));

      final chars = result.map((e) => String.fromCharCode(e)).toList();

      for (final char in chars) {
        final pointDiff = char.isLowerCase ? 96 : 38;
        final points = char.codeUnitAt(0) - pointDiff;
        copy.update('points', (value) => value + points,
            ifAbsent: () => points);
      }
      itemTypes.add(copy);
    }
  }
  final total = itemTypes.map((e) => e['points'] ?? 0).toList().sum;
  print('Total part 2: $total');
}

void day42022() {
  final fileContent = File('./assets/sources/2022/4.txt').readAsStringSync();

  final pairs =
      fileContent.split('\n').map((e) => e.trim().split(',').toList()).toList();

  var count = 0;
  var countPart2 = 0;
  for (final pair in pairs) {
    final firstPart = pair.first.split('-').map((e) => int.parse(e)).toList();
    final secondPart = pair.last.split('-').map((e) => int.parse(e)).toList();

    final firstRange = List.generate((firstPart.last - firstPart.first) + 1,
        (index) => index + firstPart.first).toList();

    final secondRange = List.generate((secondPart.last - secondPart.first) + 1,
        (index) => index + secondPart.first).toList();

    if (secondRange.every((element) => firstRange.contains(element)) ||
        firstRange.every((element) => secondRange.contains(element))) {
      count++;
    }

    if (secondRange.any((element) => firstRange.contains(element)) ||
        firstRange.any((element) => secondRange.contains(element))) {
      countPart2++;
    }
  }

  print('Part 1: $count');
  print('Part 2: $countPart2');
}

void day52022() {
  final fileContent = File('./assets/sources/2022/5.txt').readAsStringSync();
  final lines = fileContent.split('\n').toList();

  final moves = <String>[];
  final drawing = <String>[];
  final stacks = <Stack<String>>[];
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    if (line.contains('[') || line.contains(']')) {
      var currentStack = 0;
      drawing.add(line);

      final lineGroups = line.length ~/ 4;
      if (stacks.isEmpty && lineGroups > 0) {
        stacks.addAll(List.generate(lineGroups, (index) => Stack()));
      }

      for (var j = 0; j < line.length; j += 4) {
        final current = line.split('').skip(j).take(4).join('').trim();
        if (current.isEmpty) {
          currentStack++;
          continue;
        }

        if (current.startsWith('[') && current.endsWith(']')) {
          stacks[currentStack]
              .push(current.replaceAll('[', '').replaceAll(']', ''));
          currentStack++;
        }
      }
      currentStack = 0;
    } else if (line.trim().contains('move')) {
      moves.add(line);
    }
  }

  for (var stack in stacks) {
    stack.reverse();
  }

  final initialState = stacks.map((e) => Stack.clone(e)).toList();

  for (final move in moves) {
    final parts = move.split('from');
    final amount = parts.first.replaceAll('move', '').trim();
    final amountNumber = int.parse(amount);

    final fromTo = parts.last.split('to').map((e) => e.trim()).toList();
    final from = int.parse(fromTo.first) - 1;
    final to = int.parse(fromTo.last) - 1;

    final fromStack = stacks[from];
    final toStack = stacks[to];

    for (var i = 0; i < amountNumber; i++) {
      if (fromStack.isNotEmpty) {
        final last = fromStack.pop();
        toStack.push(last);
      }
    }
    stacks[from] = fromStack;
    stacks[to] = toStack;
  }

  print('Part 1:');
  final part1 = stacks.map((e) => e.peek).join('');
  print(part1);

  stacks.map((e) => e.clear());
  stacks.clear();
  stacks.addAll(initialState);

  for (final move in moves) {
    final parts = move.split('from');
    final amount = parts.first.replaceAll('move', '').trim();
    final amountNumber = int.parse(amount);

    final fromTo = parts.last.split('to').map((e) => e.trim()).toList();
    final from = int.parse(fromTo.first) - 1;
    final to = int.parse(fromTo.last) - 1;

    final fromStack = stacks[from];
    final toStack = stacks[to];

    final toPush = <String>[];
    for (var i = 0; i < amountNumber; i++) {
      if (fromStack.isNotEmpty) {
        final last = fromStack.pop();
        toPush.add(last);
      }
    }

    for (var element in toPush.reversed) {
      toStack.push(element);
    }

    stacks[from] = fromStack;
    stacks[to] = toStack;
  }

  print('Part 2:');
  final part2 =
      stacks.where((element) => element.isNotEmpty).map((e) => e.peek).join('');
  print(part2);
}

void day62022() {
  final fileContent = File('./assets/sources/2022/6.txt').readAsStringSync();

  final chars = fileContent.split('').toList();
  final previous = <String>[];
  for (var i = 0; i < chars.length; i++) {
    final current = chars[i];
    if (previous.length <= 4) {
      previous.add(current);
      continue;
    }

    if (previous.repeatedInLast(4)) {
      previous.add(current);
    } else {
      break;
    }
  }

  print('Part 1: ${previous.length}');
  previous.clear();

  for (var i = 0; i < chars.length; i++) {
    final current = chars[i];
    if (previous.length <= 14) {
      previous.add(current);
      continue;
    }

    if (previous.repeatedInLast(14)) {
      previous.add(current);
    } else {
      break;
    }
  }

  print('Part 2: ${previous.length}');
}

void day72022() {
  final fileContent = File('./assets/sources/2022/7.txt').readAsStringSync();

  final lines = fileContent.split('\n').toList();
  final tree = TreeNode(FileSystem('/'));
  final currentDir = <String>[];
  var previousCommand = '';
  for (final line in lines) {
    if (line.startsWith('\$')) {
      final parts = line.split(' ').toList();
      final action = parts[1].trim();
      final location = parts.last.trim();

      switch (action) {
        case 'cd':
          if (location == '/') {
            previousCommand = '/';
            currentDir.add('/');
            continue;
          }

          if (location == '..') {
            currentDir.removeLast();
          } else {
            currentDir.add(location);
          }

          break;

        case 'ls':
          previousCommand = 'ls';
          continue;
      }
    } else {
      if (previousCommand == 'ls') {
        final fileSystem = line.toFileSystem;
        if (fileSystem != null) {
          final treeNode = TreeNode<FileSystem>(fileSystem);

          final parent = tree.children.firstWhereOrNull(
            (node) =>
                (node.value?.isDirectory ?? false) &&
                node.value?.name.trim() == currentDir.last.trim(),
          );

          if (parent != null) {
            tree.addToNode(parent, treeNode);
          } else {
            tree.add(treeNode);
          }
          continue;
        }
      }
    }
  }

  tree.printTree();
}
