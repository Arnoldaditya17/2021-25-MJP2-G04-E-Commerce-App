import 'package:e_commerce_application_ui/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_application_ui/common/widgets/product/rating_star_bar_indicator.dart';
import 'package:e_commerce_application_ui/utils/constants/colors.dart';
import 'package:e_commerce_application_ui/utils/constants/image_strings.dart';
import 'package:e_commerce_application_ui/utils/constants/sizes.dart';
import 'package:e_commerce_application_ui/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(TImages.userProfileImage2),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Text(
                  'Aditya Singh Rajput',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_vert_sharp))
          ],
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Row(
          children: [
            const RatingStarBarIndicator(initialRating: 3.5),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              '01-Nov-2024',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        const ReadMoreText(
          "The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.",
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: 'Show less',
          trimCollapsedText: 'Show more',
          moreStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: TColors.primary),
          lessStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: TColors.primary),
        ),
        const SizedBox(height: TSizes.spaceBtwItems,),
        RoundedContainer(
          backgroundColor: darkMode ? TColors.darkerGrey : TColors.grey,

          child:  Padding(
            padding:  const EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('T\'Store',style:
                      Theme.of(context).textTheme.bodyLarge,),
                    Text('02-Nov-2023',style:
                    Theme.of(context).textTheme.bodyLarge,),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems,),
                const ReadMoreText(
                  "The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.",
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: 'Show less',
                  trimCollapsedText: 'Show more',
                  moreStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary),
                  lessStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary),
                ),

              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections,)
      ],
    );
  }
}
