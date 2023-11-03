
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things/bloc/things_state.dart';

class ThingsCubit extends Cubit<ThingsState> {
  ThingsCubit() : super(InitialState());

  void changeState(state) => emit(state);
}