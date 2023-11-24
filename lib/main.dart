import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:things/ui/activities/activity_list_page.dart';
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
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: ApplicationThemeData.darkTheme.scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.light));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const Scaffold(body: ActivityListPage()),
          theme: ApplicationThemeData.darkTheme);
    });
  }
}
