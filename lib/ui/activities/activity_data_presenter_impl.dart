import 'package:flutter/cupertino.dart';

import '../../data/local/activity_data_local_repository.dart';
import '../../data/local/activity_data_local_repository_impl.dart';
import 'activity_data_presenter.dart';
import 'bloc/activity_data_cubit.dart';
import 'bloc/activity_data_state.dart';


class ActivityDataPresenterImpl extends ActivityDataPresenter {
  final _cubit = ActivityDataCubit();
  final ActivityDataLocalRepository repository =
      ActivityDataLocalRepositoryImpl();

  @override
  Stream<ActivityDataState> thingsSateStream() {
    return _cubit.stream;
  }

  @override
  Future<void> loadThings(BuildContext context) async {
    var things = await repository.loadData(context);
    _cubit.changeState(ActivitiesLoadedSuccessfully(data: things));
  }

  @override
  void close() {
    _cubit.close();
  }
}
