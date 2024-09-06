class UnknownException<T> implements Exception{
  final T unknowData;

  UnknownException(this.unknowData);

  @override
  String toString(){
    return 'Unknown FourPillarsOfDestinyType: $unknowData of type ${T.runtimeType}';
  }
}
