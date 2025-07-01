import "package:collect/views/widget/custom_app_bar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CustomAppBar(
            title: "termsandContitions".tr,
            onBackPressed: Get.back,
            isNotificationButton: false,
          ),
          Expanded(child: contentWidget()),
        ],
      ),
    );

  Widget contentWidget() => const Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Terms and Conditions",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "1. Introduction\n"
              "By using this app, you agree to the following terms and conditions. Please read them carefully.\n",
            ),
            SizedBox(height: 8),
            Text(
              "2. Use of the App\n"
              "You agree to use the app only for lawful purposes and in accordance with these terms.\n",
            ),
            SizedBox(height: 8),
            Text(
              "3. Changes to Terms\n"
              "We reserve the right to modify these terms at any time. Continued use of the app constitutes acceptance of the new terms.\n",
            ),
            SizedBox(height: 8),
            Text(
              "4. Contact\n"
              "If you have any questions about these terms, please contact support.",
            ),
            SizedBox(height: 16),
            Text(
              "5. Privacy Policy\n"
              "Your privacy is important to us. Please review our privacy policy to understand how we collect, use, and safeguard your information.\n",
            ),
            SizedBox(height: 8),
            Text(
              "6. Limitation of Liability\n"
              "We are not liable for any damages or losses resulting from your use of the app.\n",
            ),
            SizedBox(height: 8),
            Text(
              "7. Governing Law\n"
              "These terms are governed by the laws of your jurisdiction.\n",
            ),
            SizedBox(height: 8),
            Text(
              "8. Termination\n"
              "We reserve the right to terminate or suspend your access to the app at our discretion, without notice.\n",
            ),
            SizedBox(height: 8),
            Text(
              "9. User Responsibilities\n"
              "You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.\n",
            ),
            SizedBox(height: 8),
            Text(
              "10. Third-Party Services\n"
              "The app may contain links to third-party websites or services that are not owned or controlled by us. We are not responsible for the content or practices of any third-party sites or services.\n",
            ),
            SizedBox(height: 8),
            Text(
              "11. Severability\n"
              "If any provision of these terms is found to be invalid or unenforceable, the remaining provisions will remain in effect.\n",
            ),
            SizedBox(height: 8),
            Text(
              "12. Entire Agreement\n"
              "These terms constitute the entire agreement between you and us regarding your use of the app.\n",
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
}
