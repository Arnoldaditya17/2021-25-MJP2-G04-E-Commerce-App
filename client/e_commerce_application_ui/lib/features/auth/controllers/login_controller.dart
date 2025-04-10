
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/routes/app_pages.dart';
import '../../../repository/repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/get_storage_key.dart';


class LoginController extends GetxController {
  Repository repository;

  LoginController(this.repository);

  final GetStorage _getStorage = GetStorage();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool loading=false.obs;


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void validateLogin() async {
    loading.value=true;
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      loading.value=false;
      TLoaders.errorSnackBar(
        title: "Validation Error",
        message: "Email and Password cannot be empty",
      );
      return;
    }

    try {
      Map<String, dynamic> data = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      try {
        final value = await repository.login(data);
        _getStorage.write(GetStorageKey.accessToken, value.accessToken);
        _getStorage.write(GetStorageKey.refreshToken, value.refreshToken);

        loading.value = false;
        TLoaders.successSnackBar(
          title: 'Hurray!!',
          message: "Login Successful",
        );
        Get.offAllNamed(Routes.appNavigation);
      } catch (error) {
        loading.value=false;

        TLoaders.errorSnackBar(
          title: "Error",
          message: error.toString(),
        );
      }
    } catch (exception) {
      loading.value=false;
      TLoaders.errorSnackBar(
        title: "Error",
        message: 'Something Went Wrong',
      );
    }
  }

}
