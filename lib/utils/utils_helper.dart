import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:url_launcher/url_launcher.dart";

class Utils {
  static String getGreeting() {
    final int hour = DateTime.now().hour;

    if (hour >= 5 && hour <= 11) {
      return "Good Morning";
    } else if (hour >= 12 && hour <= 16) {
      return "Good Afternoon";
    } else if (hour >= 17 && hour <= 20) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }

  static String replaceFarsiNumber(String input) {
    if (Get.locale?.languageCode == "en") return input;
    const List<String> english = <String>[
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
    ];
    const List<String> farsi = <String>[
      "۰",
      "۱",
      "۲",
      "۳",
      "۴",
      "۵",
      "۶",
      "۷",
      "۸",
      "۹",
    ];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  static String timeAgo(DateTime date) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(date);

    if (difference.inDays == 0) {
      return "Today";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays.abs()} days ago";
    } else if (difference.inDays < 30) {
      final int weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? "1 week ago" : "$weeks weeks ago";
    } else if (difference.inDays < 365) {
      final int months = (difference.inDays / 30).floor();
      return months == 1 ? "1 month ago" : "$months months ago";
    } else {
      final int years = (difference.inDays / 365).floor();
      return years == 1 ? "1 year ago" : "$years years ago";
    }
  }

  static Future<void> openMap(List<String?> latLong) async {
    final String url = "https://www.google.com/maps/dir/${latLong.join("/")}";
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
    final String url = "sms:$mobile";
    if (!await launchUrl(Uri.parse(url))) {
      // handle error if needed
    }
  }

  static String formatDate(DateTime? date, {String format = "dd/MM/yyyy"}) {
    if (date == null) return "";
    // Using intl package for formatting
    try {
      // Import 'package:intl/intl.dart'; at the top of your file
      return DateFormat(format).format(date);
    } catch (e) {
      return date.toIso8601String();
    }
  }
}
