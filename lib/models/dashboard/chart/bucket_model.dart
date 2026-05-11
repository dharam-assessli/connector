class BucketModel {
  BucketModel({
    required this.title,
    required this.score,
    required this.hexColor,
  });

  final String title;
  final num score;
  final String hexColor;
}

final List<BucketModel> sampleBucketList = <BucketModel>[
  BucketModel(title: "Bucket 01", score: 010, hexColor: "#A855F7"),
  BucketModel(title: "Bucket 02", score: 020, hexColor: "#A855F7"),
  BucketModel(title: "Bucket 03", score: 030, hexColor: "#A855F7"),
  BucketModel(title: "Bucket 04", score: 040, hexColor: "#A855F7"),
  BucketModel(title: "Bucket 05", score: 050, hexColor: "#A855F7"),
  BucketModel(title: "Bucket 06", score: 060, hexColor: "#A855F7"),
  BucketModel(title: "Bucket 07", score: 070, hexColor: "#A855F7"),
  BucketModel(title: "Bucket 08", score: 080, hexColor: "#A855F7"),
  BucketModel(title: "Bucket 09", score: 090, hexColor: "#A855F7"),
  BucketModel(title: "Bucket 10", score: 100, hexColor: "#A855F7"),
];
