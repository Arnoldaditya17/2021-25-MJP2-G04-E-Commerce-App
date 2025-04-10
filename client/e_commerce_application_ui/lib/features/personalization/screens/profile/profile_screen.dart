import 'package:e_commerce_application_ui/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application_ui/common/widgets/containers/primary_header_container.dart';
import 'package:e_commerce_application_ui/common/widgets/list_tile/setting_menu_tile.dart';
import 'package:e_commerce_application_ui/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application_ui/core/routes/app_pages.dart';
import 'package:e_commerce_application_ui/utils/constants/colors.dart';
import 'package:e_commerce_application_ui/utils/constants/sizes.dart';
import 'package:e_commerce_application_ui/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/list_tile/profile_tile.dart';
import '../../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppbar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),
                  const ProfileTileWidget(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const SectionHeading(
                    title: 'Account Setting',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SettingMenuTile(
                    subTitle: 'set shopping delivery address',
                    title: 'My Addresses',
                    icon: Iconsax.safe_home,
                    onTap: () {
                      Get.toNamed(Routes.addressScreen);
                    },
                  ),
                  SettingMenuTile(
                    subTitle: 'Your all Order are managed here',
                    title: 'My Orders',
                    icon: Iconsax.box,
                    onTap: () {},
                  ),
                  SettingMenuTile(
                    subTitle: 'Your all cart items are here',
                    title: 'My Cart',
                    icon: Iconsax.shopping_cart,
                    onTap: () {},
                  ),
                  SettingMenuTile(
                    subTitle: 'Your all bank accounts for seamless payments',
                    title: 'Your Bank Account',
                    icon: Iconsax.bank,
                    onTap: () {},
                  ),
                  SettingMenuTile(
                    subTitle: 'Your all Notifications',
                    title: 'Notifications',
                    icon: Iconsax.notification,
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const SectionHeading(
                    title: 'App Setting',
                    showActionButton: false,
                  ),
                  SettingMenuTile(
                    title: 'your location',
                    subTitle: 'always on location for this app',
                    icon: Iconsax.location,
                    onTap: () {},
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  SettingMenuTile(
                    subTitle: 'Your all Order are managed here',
                    title: 'Term & Condition',
                    icon: Iconsax.book,
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.defaultDialog(
                          radius: 15,
                          titlePadding: const EdgeInsets.only(top: 15),
                          title: 'Don\'t Leave 😢',
                          content: const Column(
                            children: [
                              Text('Are you Sure You want to Logout ?'),
                            ],
                          ),
                          contentPadding: const EdgeInsets.all(15),
                          backgroundColor: darkMode ? TColors.darkerGrey : TColors.light,
                          confirm: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                            decoration: BoxDecoration(
                              color: TColors.primary, // Replace with your preferred color
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton(
                              onPressed: () {
                                controller.logOut();
                              },
                              child: const Text(
                                'YES',
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold), // Text color to contrast background
                              ),
                            ),
                          ),
                          cancel: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.redAccent, // Replace with your preferred color
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                'NO',
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold), // Text color to contrast background
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Text('Logout'),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections * 2.5,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
