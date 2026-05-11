// ignore_for_file: always_specify_types, avoid_dynamic_calls

class ChartModel {
  ChartModel({this.predicted, this.generated});

  ChartModel.fromJson(Map<String, dynamic> json) {
    if (json["predicted"] != null) {
      predicted = <Predicted>[];
      json["predicted"].forEach((v) {
        predicted!.add(Predicted.fromJson(v));
      });
    }
    if (json["generated"] != null) {
      generated = <Predicted>[];
      json["generated"].forEach((v) {
        generated!.add(Predicted.fromJson(v));
      });
    }
  }
  List<Predicted>? predicted;
  List<Predicted>? generated;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (predicted != null) {
      data["predicted"] = predicted!.map((Predicted v) => v.toJson()).toList();
    }
    if (generated != null) {
      data["generated"] = generated!.map((Predicted v) => v.toJson()).toList();
    }
    return data;
  }
}

class Predicted {
  Predicted({this.time, this.value});

  Predicted.fromJson(Map<String, dynamic> json) {
    time = json["time"];
    value = json["value"];
  }
  String? time;
  double? value;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["time"] = time;
    data["value"] = value;
    return data;
  }
}

// final ChartModel sampleChartData = ChartModel(
//   predicted: <Predicted>[
//     Predicted(time: "00:00", value: 32),
//     Predicted(time: "01:00", value: 28),
//     Predicted(time: "02:00", value: 25),
//     Predicted(time: "03:00", value: 22),
//     Predicted(time: "04:00", value: 24),
//     Predicted(time: "05:00", value: 30),
//     Predicted(time: "06:00", value: 42),
//     Predicted(time: "07:00", value: 58),
//     Predicted(time: "08:00", value: 70),
//     Predicted(time: "09:00", value: 68),
//     Predicted(time: "10:00", value: 55),
//     Predicted(time: "11:00", value: 48),
//     Predicted(time: "12:00", value: 52),
//     Predicted(time: "13:00", value: 60),
//     Predicted(time: "14:00", value: 72),
//     Predicted(time: "15:00", value: 78),
//     Predicted(time: "16:00", value: 65),
//     Predicted(time: "17:00", value: 54),
//     Predicted(time: "18:00", value: 46),
//     Predicted(time: "19:00", value: 50),
//     Predicted(time: "20:00", value: 44),
//     Predicted(time: "21:00", value: 38),
//     Predicted(time: "22:00", value: 33),
//     Predicted(time: "23:00", value: 28),
//   ],
//   generated: <Predicted>[
//     Predicted(time: "00:00", value: 18),
//     Predicted(time: "01:00", value: 15),
//     Predicted(time: "02:00", value: 12),
//     Predicted(time: "03:00", value: 14),
//     Predicted(time: "04:00", value: 20),
//     Predicted(time: "05:00", value: 28),
//     Predicted(time: "06:00", value: 35),
//     Predicted(time: "07:00", value: 50),
//     Predicted(time: "08:00", value: 62),
//     Predicted(time: "09:00", value: 55),
//     Predicted(time: "10:00", value: 40),
//     Predicted(time: "11:00", value: 36),
//     Predicted(time: "12:00", value: 45),
//     Predicted(time: "13:00", value: 52),
//     Predicted(time: "14:00", value: 64),
//     Predicted(time: "15:00", value: 58),
//     Predicted(time: "16:00", value: 48),
//     Predicted(time: "17:00", value: 42),
//     Predicted(time: "18:00", value: 38),
//     Predicted(time: "19:00", value: 44),
//     Predicted(time: "20:00", value: 36),
//     Predicted(time: "21:00", value: 30),
//     Predicted(time: "22:00", value: 25),
//     Predicted(time: "23:00", value: 20),
//   ],
// );

final ChartModel sampleChartData = ChartModel(
  predicted: <Predicted>[
    Predicted(time: "00:00", value: 32),
    Predicted(time: "03:00", value: 22),
    Predicted(time: "06:00", value: 42),
    Predicted(time: "09:00", value: 68),
    Predicted(time: "12:00", value: 52),
    Predicted(time: "15:00", value: 78),
    Predicted(time: "18:00", value: 46),
    Predicted(time: "21:00", value: 38),
  ],
  generated: <Predicted>[
    Predicted(time: "00:00", value: 18),
    Predicted(time: "03:00", value: 14),
    Predicted(time: "06:00", value: 35),
    Predicted(time: "09:00", value: 55),
    Predicted(time: "12:00", value: 45),
    Predicted(time: "15:00", value: 58),
    Predicted(time: "18:00", value: 38),
    Predicted(time: "21:00", value: 30),
  ],
);
