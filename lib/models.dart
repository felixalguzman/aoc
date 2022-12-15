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

  FileSystem(this.name, [this.size = 0.0, this.isDirectory = true]);

  @override
  String toString() {
    return '$name - $isDirectory $size';
  }
}
