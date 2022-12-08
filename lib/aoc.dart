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

  final sorted = elfs.entries.toList();
  sorted.sort((a, b) => a.value.sum.compareTo(b.value.sum));

  final top3 = sorted.reversed.take(3);
  for (final element in top3) {
    print('Elfo ${element.key} cal: ${element.value.sum}');
  }

  final total = top3.map((e) => e.value.sum).toList().sum;
  print('Total: $total');
}
