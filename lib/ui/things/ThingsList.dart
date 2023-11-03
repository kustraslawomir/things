import 'package:flutter/material.dart';
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
      _presenter.loadThings(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("list"));
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}
