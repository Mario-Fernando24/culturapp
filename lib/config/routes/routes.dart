import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/presentation/views/admin/agenda_cultural/add_agenda_cultura.dart';
import 'package:culturappco/presentation/views/admin/agenda_cultural/agenda_cultural_list.dart';
import 'package:culturappco/presentation/views/admin/agenda_cultural/agenda_detail.dart';
import 'package:culturappco/presentation/views/admin/directorio_artista/home_artista_directorio_add.dart';
import 'package:culturappco/presentation/views/admin/directorio_artista/home_categoria_directorio_add.dart';
import 'package:culturappco/presentation/views/admin/directorio_artista/home_directorio_artista.dart';
import 'package:culturappco/presentation/views/admin/home/home_view_admin.dart';
import 'package:culturappco/presentation/views/admin/oferta_cultural/oferta_cultural_add.dart';
import 'package:culturappco/presentation/views/admin/oferta_cultural/oferta_cultural_details.dart';
import 'package:culturappco/presentation/views/admin/oferta_cultural/oferta_cultural_home.dart';
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
  agendaCulturalListviewRoutes: (_) => AgendaCulturalList(),
  addAgendaCulturalviewRoutes: (_) => AddAgendaCultura(),

  homeDirectorioArtistaCulturalviewRoutes: (_) => HomeDirectorioArtista(),
  homeDirectorioArtistaAddviewRoutes: (_) => HomeArtistaDirectorioAdd(),

  
  ofertaCulturalHomeviewRoutes: (_) => OfertaCulturalHome(),
  ofertaCulturalAddviewRoutes: (_) => OfertaCulturalAdd(),
  
   detailsOfertaCulturalviewRoutes: (_) {
    final OfertaCultural ofertaCultural = ModalRoute.of(_)!.settings.arguments as OfertaCultural;
    return OfertaCulturalDetails(ofertaCultural: ofertaCultural);
  },



  detailsAgendaCulturalviewRoutes: (_) {
    final Evento evento = ModalRoute.of(_)!.settings.arguments as Evento;
    return AgendaDetails(evento: evento);
  },
  homeDirectorioAddviewRoutes: (_) => HomeCategoriaDirectorioAdd(),

  

};
