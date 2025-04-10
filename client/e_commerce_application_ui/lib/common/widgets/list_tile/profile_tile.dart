import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/personalization/controllers/profile_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/rounded_image.dart';

class ProfileTileWidget extends GetView<ProfileController> {
  const ProfileTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    return ListTile(
      leading: const RoundedImage(
        imageUrl: TImages.user,
        width: 50,
        height: 50,
        padding: EdgeInsets.zero,
      ),
      title: Obx(() => Text(
        controller.name.value,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      )),
      subtitle: Obx(() => Text(
        controller.userEmail.value,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(color: TColors.white),
      )),
      trailing: IconButton(onPressed: () {}, icon: const Icon(Iconsax.edit)),
    );
  }
}
