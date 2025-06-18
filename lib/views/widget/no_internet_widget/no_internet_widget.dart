import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:collect/views/widget/zoom_tap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetConnection extends StatefulWidget {
  final VoidCallback? onRetry;

  const NoInternetConnection({super.key, this.onRetry});

  @override
  State<NoInternetConnection> createState() => _NoInternetConnectionState();
}

class _NoInternetConnectionState extends State<NoInternetConnection> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorUtils.whiteColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/icons/no-wi-fi.png"),
                24.heightBox,
                Text(
                  "oops".tr,
                  style: StyleUtils.kTextStyleSize24Weight600(
                    color: ColorUtils.themeColor,
                  ),
                ),
                10.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text(
                    "no_internet_message".tr,
                    textAlign: TextAlign.center,
                    style: StyleUtils.kTextStyleSize14Weight400(
                      color: ColorUtils.black.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                140.heightBox,
                SizedBox(
                  width: 277,
                  height: 50,
                  child: ZoomTapAnimation(
                    onTap: widget.onRetry,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: ColorUtils.themeColor,
                      ),
                      child: Center(
                        child: Text(
                          "try_again".tr,
                          style: StyleUtils.kTextStyleSize18Weight400(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                40.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
