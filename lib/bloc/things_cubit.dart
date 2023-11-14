import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things/bloc/things_state.dart';

class ThingsCubit extends Cubit<ThingsState> {
  ThingsCubit() : super(InitialState());

  void changeState(state) {
    debugPrint('change things cubit state to ${state.toString()}');
    emit(state);
  }
}
