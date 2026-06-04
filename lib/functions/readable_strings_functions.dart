String camelCaseToHuman(String input) {
  if (input.isEmpty) {
    return "";
  }

  final RegExp exp = RegExp("(?<=[a-z0-9])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])");

  final List<String> words = input.split(exp);

  return words
      .map((String word) {
        if (word.isEmpty) {
          return "";
        }

        return word[0].toUpperCase() + word.substring(1);
      })
      .join(" ");
}

String camelCaseToSentence(String input) {
  if (input.isEmpty) {
    return "";
  }

  final RegExp exp = RegExp("(?<=[a-z0-9])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])");

  final List<String> words = input.split(exp);

  final String joined = words.join(" ").toLowerCase();

  return joined[0].toUpperCase() + joined.substring(1);
}
