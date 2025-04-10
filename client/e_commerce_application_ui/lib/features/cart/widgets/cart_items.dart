import 'package:e_commerce_application_ui/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_application_ui/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/product/cart/cart_item.dart';
import '../../../common/widgets/product/cart/product_quantity_with_add_remove_widget.dart';
import '../../../common/widgets/texts/product_title.dart';
import '../../../utils/constants/sizes.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    required this.darkMode,
    this.showAddRemoveButtons = true,
  });

  final bool darkMode;
  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
        itemBuilder: (_, index) => RoundedContainer(
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: darkMode? Colors.white10.withOpacity(0.03) : Colors.white10,
          borderColor: darkMode ? Colors.grey:TColors.primary,
          showBorder: true,

          child: Column(
                children: [
                  TCartItems(darkMode: darkMode),
                  if (showAddRemoveButtons)
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                  if (showAddRemoveButtons)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            TProductQuantityWithAddRemove(darkMode: darkMode),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Row(
                            children: [
                              ProductTitleText(title: '\$256'),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
        ),
        itemCount: 2);
  }
}
