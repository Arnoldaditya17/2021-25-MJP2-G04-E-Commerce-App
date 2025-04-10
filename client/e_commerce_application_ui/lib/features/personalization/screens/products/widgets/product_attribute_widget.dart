import 'package:e_commerce_application_ui/common/widgets/chips/choice_chip_widget.dart';
import 'package:e_commerce_application_ui/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_application_ui/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce_application_ui/common/widgets/texts/product_title.dart';
import 'package:e_commerce_application_ui/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application_ui/utils/constants/colors.dart';
import 'package:e_commerce_application_ui/utils/constants/sizes.dart';
import 'package:e_commerce_application_ui/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ProductAttributeWidget extends StatelessWidget {
  const ProductAttributeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        RoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: darkMode ? TColors.darkerGrey : TColors.grey,
          child: Column(
            children: [
              Row(
                children: [
                  const SectionHeading(
                    title: 'variants',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const ProductTitleText(
                            title: 'price : ',
                            smallSize: true,
                          ),
                          Text(
                            '\$25',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          const ProductPriceText(price: '20'),
                        ],
                      ),
                      Row(
                        children: [
                          const ProductTitleText(
                            title: 'Stock : ',
                            smallSize: true,
                          ),
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const ProductTitleText(
                title:
                    'This is a product description of the product and can go more then 4 lines',
                smallSize: true,
                maxLines: 4,
              )
            ],
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              title: 'Colors',
              showActionButton: false,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChipWidget(
                  text: 'Green',
                  selected: true,
                  onSelected: (value) {},
                ),
                ChoiceChipWidget(
                  text: 'Blue',
                  selected: false,
                  onSelected: (value) {},
                ),
                ChoiceChipWidget(
                  text: 'Red',
                  selected: false,
                  onSelected: (value) {},
                )
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              title: 'Sizes',
              showActionButton: false,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChipWidget(
                  text: 'S',
                  selected: true,
                  onSelected: (value) {},
                ),
                ChoiceChipWidget(
                  text: 'M',
                  selected: false,
                  onSelected: (value) {},
                ),
                ChoiceChipWidget(
                  text: 'L',
                  selected: false,
                  onSelected: (value) {},
                ),
                ChoiceChipWidget(
                  text: 'XL',
                  selected: false,
                  onSelected: (value) {},
                ),
                ChoiceChipWidget(
                  text: 'XXL',
                  selected: false,
                  onSelected: (value) {},
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
