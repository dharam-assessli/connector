const int defaultHeightCm = 172;
const int minCm = 100;
const int maxCm = 220;

const (int, int) defaultHeightFt = (5, 8);
const int minFt = 3;
const int maxFt = 8;
const int inchesInFt = 12;

final List<int> cmList = <int>[for (int i = minCm; i <= maxCm; i++) i];

final List<(int, int)> ftList = <(int, int)>[
  for (int ft = minFt; ft <= maxFt; ft++)
    for (int inch = 0; inch < (ft == maxFt ? 1 : inchesInFt); inch++)
      (ft, inch),
];

int ftToCm((int, int) ft) {
  return ((ft.$1 * 30.48) + (ft.$2 * 2.54)).toInt();
}

(int, int) cmToFt(int cm) {
  final double totalInches = cm / 2.54;

  int feet = (totalInches / 12).floor();
  int inches = (totalInches % 12).round();

  if (inches == 12) {
    feet += 1;
    inches = 0;
  }

  return (feet, inches);
}
