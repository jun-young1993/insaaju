import 'package:insaaju/domain/entities/info.dart';

abstract class MeEvent {
  const MeEvent();
}

class FindMeEvent extends MeEvent {
  const FindMeEvent();
}

class SaveMeInfoEvent extends MeEvent {
  final Info info;
  const SaveMeInfoEvent({
    required this.info
  });
}