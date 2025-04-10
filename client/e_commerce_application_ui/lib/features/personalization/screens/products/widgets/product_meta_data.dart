import 'package:e_commerce_application_ui/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_application_ui/common/widgets/images/circular_image.dart';
import 'package:e_commerce_application_ui/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:e_commerce_application_ui/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce_application_ui/common/widgets/texts/product_title.dart';
import 'package:e_commerce_application_ui/features/home/models/product_model.dart';
import 'package:e_commerce_application_ui/utils/constants/colors.dart';
import 'package:e_commerce_application_ui/utils/constants/enums.dart';
import 'package:e_commerce_application_ui/utils/constants/image_strings.dart';
import 'package:e_commerce_application_ui/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';

class ProductMetaDataWidget extends StatelessWidget {
  const ProductMetaDataWidget({super.key, required this.product});
  final Content product;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final discountPercentage = product.marketPrice != null &&
        product.salePrice != null &&
        product.marketPrice! > product.salePrice!
        ? ((product.marketPrice! - product.salePrice!) /
        product.marketPrice! * 100).round()
        : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Discount and Price Row
        Row(
          children: [
            if (discountPercentage > 0) ...[
              RoundedContainer(
                radius: TSizes.sm,
                backgroundColor: TColors.secondary.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.sm, vertical: TSizes.xs),
                child: Text(
                  '$discountPercentage%',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: TColors.black),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              if (product.marketPrice != null)
                Text(
                  '₹${product.marketPrice}',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(decoration: TextDecoration.lineThrough),
                ),
              const SizedBox(width: TSizes.spaceBtwItems),
            ],
            ProductPriceText(
              price: product.salePrice?.toString() ?? '0',
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        // Product Name
        ProductTitleText(title: product.name ?? 'No Name'),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        // Status
        Row(
          children: [
            const ProductTitleText(title: 'Status'),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(
              'In Stock', // You might want to make this dynamic
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),

        // Brand
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularImage(
              image: TImages.shoeIcon, // Consider using product brand image
              width: 32,
              height: 32,
              overLayerColor: darkMode ? TColors.white : TColors.black,
            ),
            Flexible(
              child: TBrandTitleWithVerifiedIcon(
                title: product.productMetaData?.color ?? 'No Brand',
                brandTextSize: TextSizes.small,
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
      ],
    );
  }
}
