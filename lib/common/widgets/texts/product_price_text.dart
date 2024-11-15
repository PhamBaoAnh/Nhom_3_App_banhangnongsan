import 'package:flutter/material.dart';

class TProductPriceText extends StatelessWidget {
  const TProductPriceText({
    super.key,
    this.currencySign = '.000 VND',
    required this.price,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
    this.isSmall = false,
  });

  final String currencySign, price;
  final int maxLines;
  final bool isLarge;
  final bool isSmall;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      price + currencySign,
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
