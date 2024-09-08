class DuplicateException<T> implements Exception{
  final T data;

  DuplicateException(this.data);

  @override
  String toString(){
    return 'Duplicate entry found: $data of type ${T.runtimeType}.';
  }
}
