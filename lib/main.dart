import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ososs/core/resources/theme/app_theme.dart';

import 'core/routes/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations(
      [ DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OSOSS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.mainTheme,
      onGenerateRoute: AppRouter.generateRoutes,
    );
  }
}
