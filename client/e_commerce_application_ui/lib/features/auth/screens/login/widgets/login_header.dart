import 'package:e_commerce_application_ui/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: TSizes.spaceBtwSections,),
        Lottie.asset(
          'assets/lottie/Animation-1730810323729.json',
          width: 240,
          repeat: true,
          animate: true,
          reverse: true,
        ),
        // Text(
        //   TTexts.loginTitle,
        //   style: Theme.of(context).textTheme.headlineMedium,
        // ),
        // const SizedBox(
        //   height: TSizes.sm,
        // ),
        // Text(
        //   TTexts.loginSubTitle,
        //   style: Theme.of(context).textTheme.bodyMedium,
        // ),
      ],
    );
  }
}
