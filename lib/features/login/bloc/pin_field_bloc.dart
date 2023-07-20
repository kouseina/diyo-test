// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:diyo_test/app_const.dart';
import 'package:equatable/equatable.dart';

part 'pin_field_event.dart';
part 'pin_field_state.dart';

class PinFieldBloc extends Bloc<PinFieldEvent, PinFieldState> {
  PinFieldBloc() : super(PinFieldInitial(value: "")) {
    on<PinFieldInputEvent>(_onInput);
    on<PinFieldClearEvent>(_onClear);
  }

  void _onInput(PinFieldInputEvent event, Emitter<PinFieldState> emit) async {
    if (state.value.length < 4) {
      emit(PinFieldInputState(value: state.value + event.value));
    }

    await Future.delayed(const Duration(milliseconds: 110));

    if (state.value.length >= 4) {
      if (state.value == AppConst.pin) {
        emit(PinFieldCorrectState());
      } else {
        emit(PinFieldIncorrectState());
      }

      _onClear(event, emit);
    }
  }

  void _onClear(PinFieldEvent event, Emitter<PinFieldState> emit) {
    emit(PinFieldClearState());
  }
}
