import 'package:e_commerce_application_ui/utils/helpers/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';

Future<void> main() async{
  await GetStorage.init();
  Get.put(NetworkManager());
  runApp( App());
}



