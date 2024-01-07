
import 'package:culturappco/presentation/views/auth/login_view.dart';
import 'package:culturappco/presentation/views/auth/register_view.dart';
import 'package:culturappco/presentation/views/onbording/onbording.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  onbordingViewRoutes: (_) => OnbordingView(),
  loginViewRoutes: (_) => LoginView(),
  registeriewRoutes: (_) => RegisterView(),

};
