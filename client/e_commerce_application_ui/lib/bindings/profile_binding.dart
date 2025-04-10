import 'package:get/get.dart';
import '../features/personalization/controllers/profile_controller.dart';
import '../provider/my_api_provider.dart';
import '../repository/repository.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileController>(ProfileController(Repository(MyApiProvider())));
  }
}
