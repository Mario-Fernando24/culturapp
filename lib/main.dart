import 'package:culturappco/config/routes/routes.dart';
import 'package:culturappco/presentation/views/onbording/onbording.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cultura app',
      home: OnbordingView(),
      initialRoute: onbordingViewRoutes,
      routes: appRoutes,
    );
  }
}
