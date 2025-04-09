import 'package:intl/intl.dart';

int convertToInt(String text) {
  // Try to parse the string as a double first
  try {
    // Check if the string can be parsed to a double
    double number = double.parse(text);

    // If it's a double, round it to the nearest integer and return it
    return number.round();
  } catch (e) {
    // If parsing to a double fails, check if it's a valid integer
    try {
      return int.parse(text);
    } catch (e) {
      // If neither is possible, throw an exception or return a default value
      throw FormatException("Invalid number format: $text");
    }
  }
}




String formatNumberWithCommas(num number) {
  var formatter = NumberFormat('#,##0.##'); // Allows up to 2 decimal places
  return formatter.format(number);
}
