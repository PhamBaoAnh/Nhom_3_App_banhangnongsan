import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
    } else {
      return phoneNumber; // Hoặc có thể ném ra một ngoại lệ nếu không đúng định dạng
    }
  }

  static String internationalFormatPhoneNumber(String phoneNumber) {
    var digitOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Đảm bảo rằng mã vùng có chiều dài tối thiểu 2
    String countryCode = '+${digitOnly.length > 2 ? digitOnly.substring(0, 2) : ''}';
    digitOnly = digitOnly.length > 2 ? digitOnly.substring(2) : digitOnly;

    final formattedNumber = StringBuffer();
    formattedNumber.write(countryCode);

    int i = 0;
    while (i < digitOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3; // Mã quốc gia của Mỹ và Canada có 3 chữ số đầu tiên
      }

      int end = i + groupLength;
      formattedNumber.write(digitOnly.substring(i, end > digitOnly.length ? digitOnly.length : end));
      if (end < digitOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }

    return formattedNumber.toString(); // Trả về giá trị đã định dạng
  }
}
