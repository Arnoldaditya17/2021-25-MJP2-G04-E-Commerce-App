import 'package:e_commerce_application_ui/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application_ui/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_application_ui/common/widgets/success_screen/success_screen.dart';
import 'package:e_commerce_application_ui/features/cart/widgets/cart_items.dart';
import 'package:e_commerce_application_ui/features/personalization/screens/checkout/widgets/billing_address_section.dart';
import 'package:e_commerce_application_ui/features/personalization/screens/checkout/widgets/billing_amount_section.dart';
import 'package:e_commerce_application_ui/features/personalization/screens/checkout/widgets/billing_payment_section.dart';
import 'package:e_commerce_application_ui/navigation_screen.dart';
import 'package:e_commerce_application_ui/utils/constants/image_strings.dart';
import 'package:e_commerce_application_ui/utils/constants/sizes.dart';
import 'package:e_commerce_application_ui/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/product/cart/coupon_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../payment/razorpay_api_provider.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final RazorpayApiProvider razorpayApi = RazorpayApiProvider();
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              CartItems(
                darkMode: darkMode,
                showAddRemoveButtons: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const TCouponCode(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              RoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: darkMode ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    BillingAmountSection(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Divider(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    BillingPaymentSection(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    BillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () async {
            try {
              print("🛒 Initiating Payment...");

              // 🔄 Step 1: Create Order
              final orderData = await razorpayApi.createOrder(50000, "INR");

              // 🚀 Step 2: Open Razorpay Checkout
              razorpayApi.openRazorpay(orderData);
            } catch (e) {
              print("❌ Payment Error: $e");
            }
          },
          child: const Text('Checkout \$256.0'),
        ),
      ),
    );
  }
}
