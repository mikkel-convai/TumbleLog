class Skill {
  final String name;
  final DateTime date;
  final String symbol;
  final double difficulty;
  final String equipment;
  int reps;

  Skill({
    required this.name,
    required this.symbol,
    this.difficulty = 0.0,
    DateTime? date,
    this.equipment = 'rod floor',
    this.reps = 0,
  }) : date = date ?? DateTime.now();
}
