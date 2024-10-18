import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/shop/screens/home/widgets/home_appbar.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/containers/circular_container.dart';
import '../../../../common/widgets/containers/primary_header_container.dart';
import '../../../../common/widgets/curved_edges/curved_edges.dart';
import '../../../../common/widgets/products/cart_menu_icon.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeAppBar(),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}











