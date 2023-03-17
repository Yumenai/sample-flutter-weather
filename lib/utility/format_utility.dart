class FormatUtility {
  static String date(final DateTime? dateTime) {
    if (dateTime == null) return '';

    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  static String dateName(final DateTime? dateTime) {
    if (dateTime == null) return '';

    return '${dateTime.day}${numberSuffix(dateTime.day)} ${monthName(dateTime)} ${dateTime.year}';
  }

  static String time(final DateTime? dateTime) {
    if (dateTime == null) return '';

    return '${dateTime.hour > 12 ? dateTime.hour % 12 : dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour > 11 ? 'PM' : 'AM'}';
  }

  static String numberSuffix(final int? number) {
    if (number == 1) return 'st';
    if (number == 2) return 'nd';
    if (number == 3) return 'rd';

    return 'th';
  }

  static String monthName(final DateTime? dateTime) {
    if (dateTime == null) return '';

    switch(dateTime.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sept';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  static double temperatureFahrenheitToCelsius(final num fahrenheit) {
    return fahrenheit * 5/9;
  }

  const FormatUtility._();
}