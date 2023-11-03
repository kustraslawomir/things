import 'package:flutter/material.dart';
import 'package:things/bloc/things_state.dart';
import 'package:things/data/things.dart';
import 'package:things/ui/things/things_presenter.dart';

class ThingsList extends StatefulWidget {
  const ThingsList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ThingsListState();
  }
}

class _ThingsListState extends State<ThingsList> {
  final ThingsPresenter _presenter = ThingsPresenterImpl();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _presenter.thingsSateStream();
      _presenter.loadThings(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThingsState>(
        stream: _presenter.thingsSateStream(),
        builder: (BuildContext context, AsyncSnapshot<ThingsState> snapshot) {
          switch (snapshot.requireData.runtimeType) {
            case ThingsLoadedState:
              {
                List<Activities> activities =
                    (snapshot.requireData as ThingsLoadedState)
                            .things
                            .activities ??
                        <Activities>[];
                return ListView.builder(
                    itemCount: activities.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(activities[index].title ?? "");
                    });
              }
            case InitialState:
              return const CircularProgressIndicator();
            default:
              return const CircularProgressIndicator();
          }
        });
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}
