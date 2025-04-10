import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';

class RatingStarBarIndicator extends StatelessWidget {
  const RatingStarBarIndicator({
    super.key, required this.initialRating,
  });
  final double initialRating;
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating,
      allowHalfRating: true,
      minRating: 1,
      unratedColor: TColors.grey,
      glow: true,
      itemSize: 20,
      itemBuilder: (_, __) => const Icon(Iconsax.star1,color: TColors.primary,),
      onRatingUpdate: (double value) {},
    );
  }
}