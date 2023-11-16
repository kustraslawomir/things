import 'package:things/data/local/model/activity_data_model.dart';

class ActivityDataState {}

class ActivityDataInitialState extends ActivityDataState {}

class ActivitiesLoadedSuccessfully extends ActivityDataState {
  final ActivityData data;

  ActivitiesLoadedSuccessfully({required this.data});
}
