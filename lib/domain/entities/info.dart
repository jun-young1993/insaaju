class Info {
  final String name;
  final String hanja;
  final String date;
  final String time;
  const Info(this.name, this.hanja, this.date, this.time);
  // toJson 메서드
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hanja': hanja,
      'date': date,
      'time': time,
    };
  }

}