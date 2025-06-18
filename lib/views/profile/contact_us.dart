import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:collect/utils/utils_helper.dart';
import 'package:collect/views/widget/custom_app_bar.dart';
import 'package:collect/views/widget/gradient_button.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final String phone = '1234567890';
  final String sms = '1234567890';
  final String address = '123 Main Street, City, Country';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomAppBar(
            title: "Contact Us",
            onBackPressed: () => Navigator.pop(context),
          ),
          Expanded(child: content(context)),
        ],
      ),
    );
  }

  Widget content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'We would love to hear from you!',
              style: StyleUtils.kTextStyleSize18Weight600(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: nameController,
              decoration: StyleUtils.inputDecoration(
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: StyleUtils.inputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: messageController,
              decoration: StyleUtils.inputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 24),
            GradientButton(
              text: "Send",
              onClick: () {
                FocusManager.instance.primaryFocus?.unfocus();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Message sent!')));
                nameController.clear();
                emailController.clear();
                messageController.clear();
              },
            ),
            32.heightBox,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Address:',
                style: StyleUtils.kTextStyleSize18Weight600(
                  color: Colors.black.withValues(alpha: 0.8),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                address,
                style: StyleUtils.kTextStyleSize14Weight500(
                  color: Colors.black.withValues(alpha: 0.8),
                ),
              ),
            ),
            16.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                commonButton(
                  onPressed: () => Utils.dail(phone),
                  icon: Icons.call,
                  label: 'Call',
                ),
                commonButton(
                  onPressed: () => Utils.sendMessage('sms:$sms'),
                  icon: Icons.message,
                  label: 'Message',
                ),
                commonButton(
                  onPressed: () => Utils.openMap([" 37.7749", " -122.4194"]),
                  icon: Icons.map,
                  label: 'Map',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget commonButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    Color? backgroundColor,
    Color? foregroundColor,
    TextStyle? textStyle,
    double borderRadius = 8,
    double elevation = 2,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ColorUtils.themeColor,
        foregroundColor: foregroundColor ?? ColorUtils.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: elevation,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(
            label,
            style:
                textStyle ??
                StyleUtils.kTextStyleSize16Weight400(
                  color: foregroundColor ?? Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
