import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:things/bloc/activity/activity_data_state.dart';

class ActivityDataCubit extends Cubit<ActivityDataState> {

  ActivityDataCubit() : super(ActivityDataInitialState());

  void changeState(state) {
    debugPrint('change things cubit state to ${state.toString()}');
    emit(state);
  }
}
