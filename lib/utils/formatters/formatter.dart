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
    // Kiểm tra độ dài của số điện thoại
    if (phoneNumber.length == 10) {
      return '${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    } else if (phoneNumber.length == 11) { // Xử lý các số có 11 chữ số (đầu số cũ)
      return '${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    } else {
      return phoneNumber; // Trả về số gốc nếu không đúng định dạng
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
