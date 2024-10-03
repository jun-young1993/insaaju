class FourOfDestinyRequiredException<T> implements Exception{
  final T unknownData;
  FourOfDestinyRequiredException(this.unknownData);

  @override
  String toString() {
    return 'FourOfDestinyRequiredException: Required Four Pillars of Destiny data is missing. Provided data: $unknownData';
  }
}
