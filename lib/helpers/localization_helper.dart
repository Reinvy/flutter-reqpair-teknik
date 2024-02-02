import 'package:intl/intl.dart';

class LocalizationHelper {
  static String formatTgl(DateTime date) {
    final formatDate = DateFormat('EEEE, d MMMM yyyy', "id_ID");
    final formatedDate = formatDate.format(date);

    return formatedDate;
  }

  static String formatJam(DateTime date) {
    final formatDate = DateFormat('HH:mm');
    final formatedDate = formatDate.format(date);

    return formatedDate;
  }
}
