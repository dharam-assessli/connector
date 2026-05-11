const int defaultWeightKg = 70;
const int minKg = 30;
const int maxKg = 200;

const int defaultWeightLb = 154;
const int minLb = 66;
const int maxLb = 440;

final List<int> kgList = <int>[for (int i = minKg; i <= maxKg; i++) i];

final List<int> lbList = <int>[for (int i = minLb; i <= maxLb; i++) i];

int kgToLb(int kg) {
  return (kg * 2.20462).toInt();
}

int lbToKg(int lb) {
  return (lb / 2.20462).toInt();
}
