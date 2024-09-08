import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/info/info_state.dart';

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

class InputHanjaEvent extends InfoEvent {
  final List<String> hanja;
  const InputHanjaEvent({
    required this.hanja
  });
}

class InputMenuEvent extends InfoEvent {
  final InfoMenu menu;
  const InputMenuEvent({
    required this.menu
  });
}

class SaveEvent extends InfoEvent {
  final Info info;
  const SaveEvent({
    required this.info
  });
}

class CheckEvent extends InfoEvent {
  final Info info;
  const CheckEvent({
    required this.info
  });
}

class InfoInitializeEvent extends InfoEvent {

  const InfoInitializeEvent();
}
