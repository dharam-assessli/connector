String plural(int value, String singular, String plural) {
  return "$value ${value == 1 ? singular : plural}";
}
