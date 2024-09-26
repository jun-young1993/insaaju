// 모델 클래스 정의
class CodeItem {
  final int id;
  final String key;
  final String value;
  final String description;
  final String isDeleted;
  final int order;

  CodeItem({
    required this.id,
    required this.key,
    required this.value,
    required this.description,
    required this.isDeleted,
    required this.order,
  });

  factory CodeItem.fromJson(Map<String, dynamic> json) {
    return CodeItem(
      id: json['id'],
      key: json['key'],
      value: json['value'],
      description: json['description'],
      isDeleted: json['isDeleted'],
      order: json['order'],
    );
  }

  factory CodeItem.copyWith({
    int? id,
    int? order,
    String? key,
    String? value,
    String? description,
    String? isDeleted
  }){
    return CodeItem(
      id: id ?? 0, 
      order: order ?? 0, 
      key: key ?? '', 
      value: value ?? '', 
      description: description ?? '', 
      isDeleted: isDeleted ?? ''
    );
  }
}
