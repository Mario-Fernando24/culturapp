import 'package:bloc/bloc.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:culturappco/domain/repositories/homeRespository.dart';
import 'package:culturappco/utils/function/parsear_date.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:equatable/equatable.dart';
part 'usuario_state.dart';

class UsuarioCubit extends Cubit<UsuarioCubitState> {
  final HomeRespository homeRespository;

  UsuarioCubit(this.homeRespository) : super(UsuarioInitial());

  Future<void> getEventsUsuario(String search) async {
    try {
      print('1111111111111111111111111111111111');
      emit(UsuarioInitial());
       emit(UsuarioLoading());
            print('2222222222222222222222222222222222222222222222222222222');

      final get_events = await homeRespository.getEvents(search);
      print('33333333333333333333333333333333333333333333');
      print('negryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
      print(get_events.toString());
      print('negryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
      emit(GetEventsUsuario(get_events));
    } catch (e) {
      emit(UsuarioInitial());
    }
  }

  Future<void> downloadAndShare(Evento evento) async {
    try {
      emit(UsuarioLoading());
      final Dio dio = Dio();
      final tempDir = await getTemporaryDirectory();
      final path = '${tempDir.path}/image.jpg';

      await dio.download(evento.imagen, path);
      await Share.shareFiles([path],
          text:
              '*${evento.tituloEvento}* \n\n ${evento.descriptionEvento}\n\n*Fecha:* ${parsearDateTime(evento.fechaEvento)}');
      emit(UsuarioInitial());
    } catch (e) {
      emit(UsuarioInitial());
      print('Error downloading or sharing image: $e');
    }
  }

  Future<void> addEventToCalendar() async {

  final deviceCalendarPlugin = DeviceCalendarPlugin();
  bool permissionsGranted = await requestPermissions(deviceCalendarPlugin);

  if (!permissionsGranted) {
    print('Permissions not granted');
    return;
  }

  try {
    final calendarsResult = await deviceCalendarPlugin.retrieveCalendars();
    List<Calendar> calendars = calendarsResult.data!;
    if (calendars.isEmpty) {
      print('No calendars found');
      return;
    }

    final location = tz.getLocation('America/New_York'); // Ejemplo de zona horaria.
    final start = tz.TZDateTime(location, 2024, 2, 10);
    final end = tz.TZDateTime(location, 2024, 2, 10, 2); // Añade 2 horas para el final.

    final event = Event(
      calendars.first.id,
      title: 'Evento Importante',
      description: 'Descripción del Evento Importante',
      start: start,
      end: end,
    );

    final createEventResult = await deviceCalendarPlugin.createOrUpdateEvent(event);
    if (createEventResult!.isSuccess && createEventResult.data!.isNotEmpty) {
      print('Event added to calendar');
    } else {
      print('Error adding event to calendar');
    }
  } catch (e) {
    print('Error adding event to calendar: $e');
  }
}


 Future<bool> requestPermissions(DeviceCalendarPlugin deviceCalendarPlugin) async {
  var permissionsGranted = await deviceCalendarPlugin.hasPermissions();
  if (permissionsGranted.isSuccess && !permissionsGranted.data!) {
    permissionsGranted = await deviceCalendarPlugin.requestPermissions();
  }
  return permissionsGranted.isSuccess && permissionsGranted.data!;
}
}
