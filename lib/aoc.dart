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
    case 2:
      day22022();
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
  final opponentGuide = <StrategyGuide>[];
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
        : !moves[0].rockPaperScissorWon(moves[1].trim());

    final roundPoints = won ? 6 : (oppMove == playerMove ? 3 : 0);
    playerGuide.add(
        StrategyGuide(round: i, won: won, points: roundPoints + playerMove));
  }

  final playerPoints = playerGuide.map((e) => e.points).toList();
  final opponentsPoints = opponentGuide.map((e) => e.points).toList();
  print('Player points: ${playerPoints.sum} ');
  print('Opponent points: ${opponentsPoints.sum} ');
}

class StrategyGuide {
  final bool won;
  final int round;
  final int points;

  StrategyGuide({required this.round, required this.won, required this.points});
}
