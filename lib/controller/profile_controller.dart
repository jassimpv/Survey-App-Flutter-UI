import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../utils/prefernce_utils.dart';

class ProfileController extends GetxController {
  var userName = ''.obs;
  RxString buildInfo = "".obs;

  @override
  void onInit() {
    getBuildInfo();
    super.onInit();
  }

  // Example method to update user name
  void updateUserName(String name) {
    userName.value = name;
  }

  getBuildInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    buildInfo.value = "V $version +$buildNumber";
  }

  Future<void> logout() async {
    await PreferenceUtils.deleteAll();
    Get.offAllNamed('/');
  }
}
