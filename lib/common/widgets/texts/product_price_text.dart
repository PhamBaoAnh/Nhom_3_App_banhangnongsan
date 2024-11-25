import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TProductPriceText extends StatelessWidget {
  const TProductPriceText({
    super.key,
    this.currencySign = ' VND',
    required this.price,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
    this.isSmall = false,
  });

  final String currencySign;
  final String price; // Vẫn để price là String
  final int maxLines;
  final bool isLarge;
  final bool isSmall;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    // Chuyển đổi price từ String sang int và định dạng
    String formattedPrice;
    try {
      final parsedPrice = int.parse(price.replaceAll('.', '')); // Xóa dấu chấm nếu có
      formattedPrice = NumberFormat.decimalPattern('vi').format(parsedPrice);
    } catch (e) {
      formattedPrice = price; // Nếu xảy ra lỗi, giữ nguyên giá trị gốc
    }

    return Text(
      '$formattedPrice$currencySign',
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
        decoration: lineThrough ? TextDecoration.lineThrough : null,
      )
          : isSmall
          ? Theme.of(context).textTheme.headlineSmall!.apply(
        decoration: lineThrough ? TextDecoration.lineThrough : null,
      )
          : Theme.of(context).textTheme.titleSmall!.apply(
        decoration: lineThrough ? TextDecoration.lineThrough : null,
      ),
    );
  }
}
