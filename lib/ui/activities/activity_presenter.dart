import 'package:flutter/cupertino.dart';

import '../../bloc/things_cubit.dart';
import '../../bloc/things_state.dart';
import '../../data/things_repository.dart';

abstract class ThingsPresenter {
  Future<void> loadThings(BuildContext context);

  Stream<ThingsState> thingsSateStream();

  void dispose();
}

class ThingsPresenterImpl extends ThingsPresenter {

  final _cubit = ThingsCubit();
  final ThingsRepository repository = ThingsRepositoryImpl();

  @override
  Stream<ThingsState> thingsSateStream() {
    return _cubit.stream;
  }

  @override
  Future<void> loadThings(BuildContext context) async {
    var things = await repository.loadThings(context);
    _cubit.changeState(ThingsLoadedState(things: things));
  }

  @override
  void dispose() {
    _cubit.close();
  }
}
