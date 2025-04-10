import 'package:flutter/material.dart';

import '../../../../../common/widgets/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
    required this.darkMode,
    required this.images,
  });

  final bool darkMode;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    // Use first image as main image, fallback to default if empty
    final mainImage = images.isNotEmpty ? images.first : TImages.productImage6;
    // Use all images for thumbnails, or default if empty
    final thumbnailImages = images.isNotEmpty ? images : [TImages.productImage2];

    return CurvedEdgesWidget(
      child: Container(
        color: darkMode ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            // Main Product Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: Image(
                    image: NetworkImage(mainImage), // Changed to NetworkImage
                  ),
                ),
              ),
            ),

            // Image Thumbnails
            Positioned(
              left: TSizes.defaultSpace,
              right: 0,
              bottom: 30,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemBuilder: (_, index) => RoundedImage(
                    width: 80,
                    backgroundColor: darkMode ? TColors.dark : TColors.white,
                    border: Border.all(color: TColors.primary),
                    padding: const EdgeInsets.all(TSizes.sm),
                    imageUrl: thumbnailImages[index], // Use actual image URLs
                    isNetworkImage: true, // Enable network images
                  ),
                  separatorBuilder: (_, __) => const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  itemCount: thumbnailImages.length, // Dynamic count
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}