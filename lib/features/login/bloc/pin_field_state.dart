part of 'pin_field_bloc.dart';

abstract class PinFieldState extends Equatable {
  String value;
  PinFieldState({required this.value});

  @override
  List<Object> get props => [value];
}

class PinFieldInitial extends PinFieldState {
  PinFieldInitial({required super.value});
}

class PinFieldInputState extends PinFieldState {
  PinFieldInputState({required super.value});
}

class PinFieldClearState extends PinFieldState {
  PinFieldClearState() : super(value: "");
}

class PinFieldCorrectState extends PinFieldState {
  PinFieldCorrectState() : super(value: "");
}

class PinFieldIncorrectState extends PinFieldState {
  PinFieldIncorrectState() : super(value: "");
}
