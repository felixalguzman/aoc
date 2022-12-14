import 'package:aoc/extensions.dart';

class StrategyGuide {
  final bool won;
  final int round;
  final int points;

  StrategyGuide({required this.round, required this.won, required this.points});
}

class FileSystem {
  final String name;
  final double size;
  final bool isDirectory;
  final List<FileSystem> children;

  FileSystem(this.name, this.size, this.isDirectory,
      [this.children = const []]);

  void addFileToDir(FileSystem file) {
    if (isDirectory) {
      children.add(file);
    }
  }

  double get directorySize {
    if (!isDirectory) {
      return size;
    }

    return children.map((element) => element.directorySize).toList().sum;
  }
}
