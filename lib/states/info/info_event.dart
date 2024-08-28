abstract class InfoEvent {
  const InfoEvent();
}

class InputNameEvent extends InfoEvent {
  final String name;
  const InputNameEvent({
    required this.name
  });
}

class InputDateEvent extends InfoEvent {
  final String date;
  const InputDateEvent({
    required this.date
  });
}

class InputTimeEvent extends InfoEvent {
  final String time;
  const InputTimeEvent({
    required this.time, 
  });
}