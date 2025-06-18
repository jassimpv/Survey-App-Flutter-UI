import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour <= 11) {
      return 'Good Morning';
    } else if (hour >= 12 && hour <= 16) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour <= 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  static String replaceFarsiNumber(String input) {
    if (Get.locale?.languageCode == 'en') return input;
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays.abs()} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    }
  }

  static Future<void> openMap(List<String?> latLong) async {
    final url = "https://www.google.com/maps/dir/${latLong.join("/")}";
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      // handle error if needed
    }
  }

  static Future<void> dail(String mobile) async {
    if (!await launchUrl(Uri.parse("tel:$mobile"))) {
      // handle error if needed
    }
  }

  static Future<void> sendMessage(String mobile) async {
    if (mobile.isEmpty) return;
    final url = "sms:$mobile";
    if (!await launchUrl(Uri.parse(url))) {
      // handle error if needed
    }
  }
}
