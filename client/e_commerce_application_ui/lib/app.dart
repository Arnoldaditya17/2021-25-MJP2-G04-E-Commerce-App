import 'package:e_commerce_application_ui/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'core/routes/app_pages.dart';
import 'features/auth/models/get_storage_key.dart';

class App extends StatelessWidget {
   App({super.key});
  final _getStorage = GetStorage();


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Leaning Application',
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialRoute: _getStorage.read(GetStorageKey.accessToken)==null
          ?AppPages.appNavigation
          :AppPages.appNavigation,
      getPages: AppPages.routes,
    );
  }
}