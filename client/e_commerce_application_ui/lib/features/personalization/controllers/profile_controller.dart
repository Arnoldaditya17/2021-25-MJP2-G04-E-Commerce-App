import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/routes/app_pages.dart';
import '../../../repository/repository.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  Repository repository;

  ProfileController(this.repository);

  var userEmail = ''.obs;
  var name = ''.obs;
  final _getStorage = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    getProfile();
  }

  @override
  void onClose() {}

  void getProfile() async {
    try {
      isLoading(true);

      repository.getProfile().then((value) {
        isLoading(false);
        name.value = value.name.toString();
        userEmail.value = value.email.toString();
      }).onError((error, stackTrace) {
        isLoading(false);
      });
    } catch (exception) {
      isLoading(false);
    }
  }

  logOut() {
    _getStorage.erase();
    Get.offAllNamed(Routes.login);
  }
}
