import 'package:flutter/material.dart';
import 'package:things/ui/things/ThingsList.dart';

void main() => runApp(const ThingsApplication());

class ThingsApplication extends StatefulWidget {
  const ThingsApplication({super.key});

  @override
  State<StatefulWidget> createState() {
    return ThingsApplicationState();
  }
}

class ThingsApplicationState extends State<ThingsApplication> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: ThingsList()),
    );
  }
}
