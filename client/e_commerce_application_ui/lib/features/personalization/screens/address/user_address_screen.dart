import 'package:e_commerce_application_ui/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application_ui/core/routes/app_pages.dart';
import 'package:e_commerce_application_ui/features/personalization/screens/address/widgets/single_address_widget.dart';
import 'package:e_commerce_application_ui/utils/constants/colors.dart';
import 'package:e_commerce_application_ui/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () {
          Get.toNamed(Routes.addNewAddressScreen);
        },
        child: const Icon(
          Iconsax.add,
          color: TColors.light,
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SingleAddress(
                selectedAddress: true,
              ),
              SingleAddress(
                selectedAddress: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
