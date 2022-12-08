import 'dart:io';
import 'package:aoc/extensions.dart';

int calculate() {
  return 6 * 7;
}

void resolve(int day, [int year = 2022]) {
  switch (day) {
    case 1:
      day12022();
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

  var biggestIndex = -1;
  for (final group in elfs.entries) {
    if (biggestIndex == -1) {
      biggestIndex = group.key;
      continue;
    }

    final previousBiggest = elfs[biggestIndex]?.sum ?? 0;

    final currentBiggest = group.value.sum;
    if (currentBiggest > previousBiggest) {
      biggestIndex = group.key;
    }
  }
  print('Mayor elfo ${biggestIndex + 1} con ${elfs[biggestIndex]!.sum}');
}
