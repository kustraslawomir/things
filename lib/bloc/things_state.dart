import 'package:things/data/things.dart';
class ThingsState {}

class InitialState extends ThingsState {}

class ThingsLoadedState extends ThingsState {
  final Things things;
  ThingsLoadedState({required this.things});
}