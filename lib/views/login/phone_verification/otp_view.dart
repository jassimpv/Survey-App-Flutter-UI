import "dart:async";
import "package:collect/utils/colors_utils.dart";
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
    builder: (BuildContext context, BoxConstraints constraint) => SizedBox(
      width: 74 * 4,
      child: PinCodeTextField(
        appContext: context,
        pastedTextStyle: TextStyle(
          color: Colors.green.shade600,
          fontWeight: FontWeight.bold,
        ),
        length: 4,
        obscureText: false,
        animationType: AnimationType.fade,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(16),
          fieldHeight: 70,
          fieldWidth: 64,
          inactiveColor: Colors.transparent,
          selectedColor: Colors.transparent,
          activeColor: Colors.transparent,
          errorBorderColor: ColorUtils.greyLightTextColor,
          inactiveFillColor: ColorUtils.scaffoldColor,
          selectedFillColor: Colors.white,
          activeFillColor: ColorUtils.whiteColor,
        ),
        enableActiveFill: true,
        cursorColor: ColorUtils.themeColor,
        animationDuration: const Duration(milliseconds: 300),
        textStyle: const TextStyle(
          fontSize: 24,
          height: 1.4,
          fontWeight: FontWeight.w600,
        ),
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
}
