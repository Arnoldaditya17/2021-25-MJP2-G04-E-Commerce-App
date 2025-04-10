

import 'package:get/get.dart';

import '../features/auth/controllers/login_controller.dart';
import '../provider/my_api_provider.dart';
import '../repository/repository.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
   Get.put<LoginController>(
     LoginController(Repository(MyApiProvider())));
  }

}
