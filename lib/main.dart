import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:things/ui/activities/activity_list.dart';
import 'package:things/ui/theme/application_theme_data.dart';

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
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
          home: const Scaffold(body: ActivityListWidget()),
          theme: ApplicationThemeData.lightTheme,
          darkTheme: ApplicationThemeData.darkTheme);
    });
  }
}
