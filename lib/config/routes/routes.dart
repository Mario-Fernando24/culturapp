import 'package:culturappco/presentation/views/admin/home/home_view_admin.dart';
import 'package:culturappco/presentation/views/admin/profile/perfil_view.dart';
import 'package:culturappco/presentation/views/auth/login_view.dart';
import 'package:culturappco/presentation/views/auth/register_view.dart';
import 'package:culturappco/presentation/views/onbording/onbording.dart';
import 'package:culturappco/presentation/views/users/home/home_view_user.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  onbordingViewRoutes: (_) => OnbordingView(),
  loginViewRoutes: (_) => LoginView(),
  registeriewRoutes: (_) => RegisterView(),
  homeAdminviewRoutes: (_) => HomeViewAdmin(),
  homeUserviewRoutes: (_) => HomeViewUser(),
  profileUsviewRoutes: (_) => PerfilView(),
};
