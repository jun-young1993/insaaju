class RequiredException<T> implements Exception{
  final T unknowData;

  RequiredException(this.unknowData);

  @override
  String toString(){
    return 'RequiredException: Required data is missing. Provided data: $unknowData';
  }
}
