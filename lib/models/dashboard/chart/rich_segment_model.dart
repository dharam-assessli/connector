class RichSegmentModel {
  RichSegmentModel({
    required this.text,
    required this.color,
    required this.weight,
  });

  factory RichSegmentModel.fromJson(Map<String, dynamic> json) {
    return RichSegmentModel(
      text: json["text"] as String,
      color: json["color"] as String,
      weight: json["weight"] as String,
    );
  }

  final String text;
  final String color;
  final String weight; // "bold" | "regular"
}

class RichMessage {
  RichMessage({required this.segments});

  factory RichMessage.fromJson(Map<String, dynamic> json) {
    final List<RichSegmentModel> list = (json["segments"] as List<dynamic>).map(
      // ignore: avoid_annotating_with_dynamic
      (dynamic e) {
        return RichSegmentModel.fromJson(e as Map<String, dynamic>);
      },
    ).toList();

    return RichMessage(segments: list);
  }

  final List<RichSegmentModel> segments;
}

final Map<String, List<dynamic>> sampleData =
    <String, List<Map<String, String>>>{
      "segments": <Map<String, String>>[
        <String, String>{
          "text": "You stayed on top of your meetings today from ",
          "color": "#00000000",
          "weight": "regular",
        },
        <String, String>{
          "text": "75% to 100%",
          "color": "#3DDC97",
          "weight": "bold",
        },
        <String, String>{
          "text": ". You moved a bit more than usual too steps ",
          "color": "#00000000",
          "weight": "regular",
        },
        <String, String>{
          "text": "📈 ",
          "color": "#3DDC97",
          "weight": "regular",
        },
        <String, String>{"text": "8%", "color": "#3DDC97", "weight": "bold"},
        <String, String>{
          "text": ". Just make sure you're drinking enough water 💧",
          "color": "#00000000",
          "weight": "regular",
        },
      ],
    };
