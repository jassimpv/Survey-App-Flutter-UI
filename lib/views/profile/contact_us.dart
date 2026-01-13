import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/sized_box_extension.dart";
import "package:collect/utils/textstyle_input.dart";
import "package:collect/utils/utils_helper.dart";
import "package:collect/views/widget/custom_app_bar.dart";
import "package:collect/views/widget/gradient_button.dart";
import "package:collect/views/widget/zoom_tap.dart";
import "package:flutter/material.dart";

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final String phone = "1234567890";
  final String sms = "1234567890";
  final String address = "123 Main Street, City, Country";

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ColorUtils.scaffoldColor, Colors.white],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CustomAppBar(
            title: "Contact Us",
            onBackPressed: () => Navigator.pop(context),
            isNotificationButton: false,
          ),
          Expanded(child: content(context)),
        ],
      ),
    ),
  );

  Widget content(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
    child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: ColorUtils.themeColor.withValues(alpha: 0.18),
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "We would love to hear from you!",
              style: StyleUtils.kTextStyleSize18Weight600(
                color: ColorUtils.headingColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: nameController,
              decoration: StyleUtils.inputDecoration(
                hintText: "Enter your name",
                labelText: "Name",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: StyleUtils.inputDecoration(
                hintText: "Enter your email",
                labelText: "Email",
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: messageController,
              decoration: StyleUtils.inputDecoration(
                hintText: "Enter your message",
                labelText: "Message",
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
                ).showSnackBar(const SnackBar(content: Text("Message sent!")));
                nameController.clear();
                emailController.clear();
                messageController.clear();
              },
            ),
            32.heightBox,
            Text(
              "Address:",
              style: StyleUtils.kTextStyleSize18Weight600(
                color: ColorUtils.headingColor,
              ),
            ),
            Text(
              address,
              style: StyleUtils.kTextStyleSize16Weight400(color: Colors.white),
            ),
            16.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                commonButton(
                  onPressed: () => Utils.dail(phone),
                  icon: Icons.call,
                  label: "Call",
                ),
                commonButton(
                  onPressed: () => Utils.sendMessage("sms:$sms"),
                  icon: Icons.message,
                  label: "Message",
                ),
                commonButton(
                  onPressed: () =>
                      Utils.openMap(<String?>[" 37.7749", " -122.4194"]),
                  icon: Icons.map,
                  label: "Map",
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Widget commonButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) => ZoomTapAnimation(
    onTap: onPressed,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            ColorUtils.themeColor,
            ColorUtils.themeColor.withValues(alpha: 0.75),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ColorUtils.themeColor.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: StyleUtils.kTextStyleSize16Weight400(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
