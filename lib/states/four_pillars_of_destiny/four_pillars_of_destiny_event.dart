
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

  SendMessageFourPillarsOfDestinyEvent({
    required this.fourPillarsOfDestinyType,
    required this.info
  });
  
}

