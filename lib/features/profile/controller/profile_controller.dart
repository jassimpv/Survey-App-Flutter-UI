import "package:collect/core/utils/prefernce_utils.dart";
import "package:get/get.dart";
import "package:package_info_plus/package_info_plus.dart";

class ProfileController extends GetxController {
  RxString userName = "".obs;
  RxString buildInfo = "".obs;

  @override
  Future<void> onInit() async {
    await getBuildInfo();
    super.onInit();
  }

  // Example method to update user name
  void updateUserName(String name) {
    userName.value = name;
  }

  Future<void> getBuildInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final String version = packageInfo.version;
    final String buildNumber = packageInfo.buildNumber;

    buildInfo.value = "V $version +$buildNumber";
  }

  Future<void> logout() async {
    await PreferenceUtils.deleteAll();
    await Get.offAllNamed("/");
  }
}
