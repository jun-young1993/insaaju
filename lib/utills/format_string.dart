String formatString(String template, List<String> values) {
  int index = 0;
  return template.replaceAllMapped("%s", (match) {
    return values[index++];
  });
}
