import 'package:e_commerce_application_ui/features/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({
    super.key,
    this.iconColor,
    required this.onPressed, this.counterBgColor, this.counterTextColor,
  });

  final Color? iconColor,counterBgColor,counterTextColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: ()=> Get.to(()=> const CartScreen()),
          icon: Icon(Iconsax.shopping_bag,color: iconColor,),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.redAccent.withOpacity(0.78),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                '3',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(color: TColors.white, fontSizeFactor: 0.8),
              ),
            ),
          ),
        )
      ],
    );
  }
}
