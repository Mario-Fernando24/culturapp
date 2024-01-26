import 'package:intl/intl.dart';

String parsearDateTime(String date) {

  DateTime fecha = DateTime.parse(date);
  String nameDay = DateFormat('EEEE', 'es_ES').format(fecha);
  String nameMonth = DateFormat('MMMM', 'es_ES').format(fecha);

  int dayOfMonth = fecha.day;

  int ano = fecha.year;
  String fechaParseada = '${nameDay}, ${dayOfMonth} de ${nameMonth} de ${ano}';

  return fechaParseada;
}