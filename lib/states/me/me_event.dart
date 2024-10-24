import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/info/info_state.dart';

abstract class MeEvent {
  const MeEvent();
}

class FindMeEvent extends MeEvent {
  const FindMeEvent();
}

class SaveMeInfoEvent extends MeEvent {
  final InfoState infoState;
  const SaveMeInfoEvent({
    required this.infoState
  });
}