import 'package:flutter/material.dart';

class TProductPriceText extends StatelessWidget {
  const TProductPriceText({
    super.key,
    this.currencySign = ' VND',
    required this.price,
    this.maxLines =1,
    this.isLarge = false,
    this.lineThrough = false,
  });
  final String currencySign, price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
        price + currencySign,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,

        style: isLarge
            ? Theme.of(context).textTheme.headlineMedium!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null)
            :  Theme.of(context).textTheme.titleSmall!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null)
    );
  }
}