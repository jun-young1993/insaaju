abstract class InfoEvent {
  const InfoEvent();
}

class InputNameEvent extends InfoEvent {
  final String name;
  const InputNameEvent({
    required this.name
  });
}