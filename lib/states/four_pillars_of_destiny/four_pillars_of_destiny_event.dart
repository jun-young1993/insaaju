
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';

abstract class FourPillarsOfDestinyEvent {
  const FourPillarsOfDestinyEvent();
}

class InitializeFourPillarsOfDestinyEvent extends FourPillarsOfDestinyEvent{
  final Info info;

  InitializeFourPillarsOfDestinyEvent({required this.info});
}

class SelectedInfoFourPillarsOfDestinyEvent extends FourPillarsOfDestinyEvent{
  final Info info;

  SelectedInfoFourPillarsOfDestinyEvent({required this.info});
}

class SendMessageFourPillarsOfDestinyEvent extends FourPillarsOfDestinyEvent {
  final FourPillarsOfDestinyType fourPillarsOfDestinyType;
  final Info info;
  final String modelCode;

  SendMessageFourPillarsOfDestinyEvent({
    required this.fourPillarsOfDestinyType,
    required this.info,
    required this.modelCode
  });
  
}
class SendMessageFourPillarsOfDestinyCompatibilityEvent extends FourPillarsOfDestinyEvent {
  final FourPillarsOfDestinyCompatibilityType fourPillarsOfDestinyCompatibilityType;
  final List<Info> info;
  final String modelCode;

  SendMessageFourPillarsOfDestinyCompatibilityEvent({
    required this.fourPillarsOfDestinyCompatibilityType,
    required this.info,
    required this.modelCode
  });

}

class ShowFourPillarsOfDestinyEvent extends FourPillarsOfDestinyEvent {
  final Info info;
  ShowFourPillarsOfDestinyEvent({
    required this.info
  });
}

class UnSelectedInfoFourPillarsOfDestinyEvent extends FourPillarsOfDestinyEvent {
  UnSelectedInfoFourPillarsOfDestinyEvent();
}


