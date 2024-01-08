import 'package:culturappco/config/routes/routes.dart';
import 'package:culturappco/data/authRepositoryImp.dart';
import 'package:culturappco/presentation/cubits/loginCubits/auth_cubit.dart';
import 'package:culturappco/presentation/views/onbording/onbording.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';


void main()async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthRespositoryImpl();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(authenticationRepository),
        ),
        // Agrega otros Cubits aquí si los tienes
      ],
      child: const MyApp(),
    ),
  );
}

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
