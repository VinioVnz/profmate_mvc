import 'package:intl/intl.dart';

class DateConverterUtil {
  // Converte de String dd/MM/yyyy para DateTime
  static DateTime? fromUserInput(String strDate) {
    try {
      return DateFormat('dd/MM/yyyy').parseStrict(strDate);
    } catch (_) {
      return null;
    }
  }

   // Converte DateTime para formato do banco (DateTime yyyy-MM-dd)
  static DateTime toDatabaseFormat(DateTime date) {
    // Cria novo DateTime só com ano, mês e dia (sem hora/minuto)
    return DateTime(date.year, date.month, date.day);
  }

  // Converte DateTime para exibição ao usuário (dd/MM/yyyy)
  static String toUserFormat(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}