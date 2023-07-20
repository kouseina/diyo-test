part of 'pin_field_bloc.dart';

abstract class PinFieldEvent extends Equatable {
  const PinFieldEvent();

  @override
  List<Object> get props => [];
}

final class PinFieldInputEvent extends PinFieldEvent {
  String value;

  PinFieldInputEvent(this.value);
}

final class PinFieldClearEvent extends PinFieldEvent {}
