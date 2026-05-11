import "package:connector/models/dashboard/chart/bucket_model.dart";

String getPercentage(List<BucketModel> bucketList) {
  return "${(bucketList.map((BucketModel e) {
        return e.score;
      }).reduce((num a, num b) {
        return a + b;
      }) / bucketList.length).round()}%";
}
