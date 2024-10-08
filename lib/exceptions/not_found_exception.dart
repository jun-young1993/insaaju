class NotFoundException<T> implements Exception{
  final T unknowData;

  NotFoundException(this.unknowData);

  @override
  String toString(){
    return 'RequiredException: Required data is missing. Provided data: $unknowData';
  }
}
