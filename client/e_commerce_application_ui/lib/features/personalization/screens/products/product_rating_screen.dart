import 'package:e_commerce_application_ui/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application_ui/features/personalization/screens/products/widgets/over_all_product_rating.dart';
import 'package:e_commerce_application_ui/features/personalization/screens/products/widgets/user_review_card.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/product/rating_star_bar_indicator.dart';
import '../../../../utils/constants/sizes.dart';

class ProductRatingScreen extends StatelessWidget {
  const ProductRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppbar(
        title: Text("Reviews & Rating"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Rating and reviews are verified and given by the people who uses our app'),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const OverAllProductRating(),
              const RatingStarBarIndicator(initialRating: 3.5,),
              Text('12,654',style: Theme.of(context).textTheme.bodySmall,),
              const SizedBox(height: TSizes.spaceBtwSections,),
              const UserReviewCard(),

            ],
          ),
        ),
      ),
    );
  }
}


