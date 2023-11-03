import 'package:flutter/cupertino.dart';

import '../../bloc/things_cubit.dart';
import '../../bloc/things_state.dart';
import '../../data/things_repository.dart';

abstract class ThingsPresenter {
  Future<void> loadThings(BuildContext context);

  void dispose();
}

class ThingsPresenterImpl extends ThingsPresenter {
  final cubit = ThingsCubit();
  final ThingsRepository repository = ThingsRepositoryImpl();

  @override
  Future<void> loadThings(BuildContext context) async {
    var things = await repository.loadThings(context);
    cubit.changeState(ThingsLoadedState(things: things));
  }

  @override
  void dispose() {
    cubit.close();
  }
}
