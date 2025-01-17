import 'package:culturappco/config/routes/routes.dart';
import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/data/authRepositoryImp.dart';
import 'package:culturappco/data/directoriArtistaRepositoryImpl.dart';
import 'package:culturappco/data/homeRepositoryImp.dart';
import 'package:culturappco/data/ofertasCulturalesRepositoryImp.dart';
import 'package:culturappco/presentation/cubits/directoryArtistaCubit/directory_artista_usuario_cubit.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/presentation/cubits/loginCubits/auth_cubit.dart';
import 'package:culturappco/presentation/cubits/ofertaCulturalUsuarioCubit/oferta_cultural_usuario_cubit.dart';
import 'package:culturappco/presentation/cubits/usuarioCubits/usuario_cubit.dart';
import 'package:culturappco/presentation/views/onbording/onbording.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:culturappco/utils/function/preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null);
  await UserPreferences.init();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  tz.initializeTimeZones(); // Necesario para inicializar los datos de zona horaria.


  final authenticationRepository = AuthRespositoryImpl();
  final homeRepository = HomeRespositoryImpl();


final ofertasCulturalesRepository = OfertasCulturalesRepositoryImp();
final directoryArtistaRepository = DirectoriArtistaRepositoryImp();
  
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(create:        (context) => AuthenticationCubit(authenticationRepository)),
        BlocProvider<HomeCubit>(create:                  (context) => HomeCubit(homeRepository)),
        BlocProvider<UsuarioCubit>(create:               (context) => UsuarioCubit(homeRepository)),
        BlocProvider<OfertaCulturalUsuarioCubit>(create: (context) => OfertaCulturalUsuarioCubit(ofertasCulturalesRepository)),
        BlocProvider<DirectoryArtistaCubit>(create:      (context) => DirectoryArtistaCubit(directoryArtistaRepository)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: PrimaryGreyColors,
        statusBarIconBrightness: Brightness.light,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'cultura app',
        home: OnbordingView(),
        initialRoute: onbordingViewRoutes,
        //initialRoute: homeUserviewRoutes,
        routes: appRoutes,
      ),
    );
  }
}



