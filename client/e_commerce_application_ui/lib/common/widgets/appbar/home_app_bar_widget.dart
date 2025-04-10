import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/personalization/controllers/profile_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text_strings.dart';
import '../icons/cart_badge_icon.dart';
import 'appbar.dart';

class HomeAppBarWidget extends StatelessWidget{
  const HomeAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    return TAppbar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: TColors.grey),
          ),
          Obx(
            ()=> Text(
              controller.name.value,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: TColors.white),
            ),
          ),
        ],
      ),
      action: [
        CartCounterIcon(
          iconColor: TColors.white, onPressed: () { },
        )
      ],
    );
  }
}