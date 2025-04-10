import 'package:e_commerce_application_ui/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class SettingMenuTile extends StatelessWidget {
  const SettingMenuTile({super.key, required this.subTitle, required this.title, required this.icon, this.trailing, this.onTap});

  final String subTitle,title;
  final IconData icon;
  final Widget?trailing;
  final VoidCallback ? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      leading: Icon(
        icon,
        size: 28,
        color: TColors.primary,
      ),
      trailing: trailing,
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      onTap: onTap,
    );
  }
}
