import 'package:flutter/material.dart';
import 'package:project/utils/constants/colors.dart';

import '../../../utils/helpers/helper_functions.dart';
import '../containers/circular_container.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip( {
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final color = THelperFunctions.getColor(text);
    final isColor = color != null;

    return ChoiceChip(
      label: isColor ? const SizedBox() : Text(text),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(color: selected ? TColors.white : null),
      selectedColor: isColor ? color : TColors.primary,
      /*
      avatar: isColor
          ? TCircularContainer(
        width: 50,
        height: 50,
        backgroundColor: color,
      )
          : null,
      labelPadding: isColor ? const EdgeInsets.all(0) : null,
      padding: isColor ? const EdgeInsets.all(0) : null,
      shape: isColor ? const CircleBorder() : null,

       */
      backgroundColor: isColor ? color : null,
    );
  }
}
