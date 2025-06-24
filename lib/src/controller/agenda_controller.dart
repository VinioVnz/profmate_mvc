import 'package:intl/intl.dart';

class AgendaController {
  bool isDataValida(String input){
    try {
      DateFormat('dd/MM/yyyy').parseStrict(input);
      return true;
    } catch (e) {
      return false;
    }
  }
}