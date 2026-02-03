import "dart:async";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:pin_code_fields/pin_code_fields.dart";

class OTPView extends StatefulWidget {
  const OTPView({required this.onSubmit, super.key, this.otp});
  final Function(String otp) onSubmit;
  final String? otp;

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  TapGestureRecognizer onTapRecognizer = TapGestureRecognizer();

  final TextEditingController _textEditingController = TextEditingController();
  late StreamController<ErrorAnimationType> errorController;
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    _textEditingController.text = widget.otp ?? "";
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraint) {
      final double totalWidth = constraint.maxWidth.isFinite
          ? constraint.maxWidth
          : MediaQuery.of(context).size.width - 48;

      // Desired spacing between fields (approx)
      const double desiredSpacing = 16.0;
      final double usableWidth = (totalWidth - (desiredSpacing * 3)).clamp(
        160.0,
        totalWidth,
      );
      final double fieldWidth = (usableWidth / 4).clamp(40.0, 80.0);
      final double fieldHeight = (fieldWidth * 1.1).clamp(48.0, 80.0);
      final double fontSize = (fieldWidth * 0.36).clamp(18.0, 28.0);

      final double totalWidgetWidth = fieldWidth * 4 + desiredSpacing * 3;

      return Center(
        child: SizedBox(
          width: totalWidgetWidth,
          child: PinCodeTextField(
            appContext: context,
            pastedTextStyle: StyleUtils.kTextStyleOtpPasted(),
            length: 4,
            obscureText: false,
            animationType: AnimationType.fade,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(16),
              fieldHeight: fieldHeight,
              fieldWidth: fieldWidth,
              inactiveColor: Colors.transparent,
              selectedColor: Colors.transparent,
              activeColor: Colors.transparent,
              errorBorderColor: ThemeColors.greyLightTextColor,
              inactiveFillColor: ThemeColors.scaffoldColor,
              selectedFillColor: ThemeColors.whiteColor,
              activeFillColor: ThemeColors.whiteColor,
            ),
            enableActiveFill: true,
            cursorColor: ThemeColors.themeColor,
            animationDuration: const Duration(milliseconds: 300),
            textStyle: StyleUtils.kTextStyleOtpInput(fontSize: fontSize),
            backgroundColor: Colors.transparent,
            errorAnimationController: errorController,
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            onCompleted: (String v) {
              widget.onSubmit.call(v);
            },
            onChanged: (String value) {},
            beforeTextPaste: (String? text) => true,
          ),
        ),
      );
    },
  );
}
