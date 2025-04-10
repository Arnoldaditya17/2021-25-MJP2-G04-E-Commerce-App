import 'package:e_commerce_application_ui/common/widgets/icons/circular_icons.dart';
import 'package:e_commerce_application_ui/features/home/models/product_model.dart';
import 'package:e_commerce_application_ui/utils/constants/colors.dart';
import 'package:e_commerce_application_ui/utils/constants/sizes.dart';
import 'package:e_commerce_application_ui/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key, required Content product});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Container(

      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace / 2,
          vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: darkMode ? TColors.darkerGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircularIcon(
                icon: Iconsax.minus,
                backgroundColor: TColors.dark,
                width: 40,
                height: 40,
                color: Colors.white,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Text(
                '2',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              const CircularIcon(
                icon: Iconsax.add,
                backgroundColor: TColors.black,
                width: 40,
                height: 40,
                color: Colors.white,
              ),
            ],
          ),
          Container(
            height: 55,
            width: 150,
            decoration: BoxDecoration(
                color: TColors.black,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: TColors.grey, width: 0.5)),
            child: Row(
              children: [
                Lottie.asset(
                  'assets/lottie/Animation - 1730876621331.json',
                ),
                 const Text(
                  'Add To Cart',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,color:TColors.textWhite),
                ),
              ],
            ),
          )

          // ElevatedButton(
          //   onPressed: () {},
          //   style: ElevatedButton.styleFrom(
          //       backgroundColor: TColors.black,
          //       padding: const EdgeInsets.all(TSizes.md),
          //       side: const BorderSide(color: TColors.black)),
          //   child: const Text('Add To Cart'),
          // )
        ],
      ),
    );
  }
}
