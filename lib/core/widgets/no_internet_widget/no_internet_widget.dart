import "package:collect/core/utils/colors_utils.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:collect/core/widgets/gradient_button.dart";
import "package:collect/core/widgets/language_widget.dart";
import "package:collect/core/utils/asset_utils.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get.dart";

class NoInternetConnection extends StatefulWidget {
  const NoInternetConnection({super.key, this.onRetry});
  final VoidCallback? onRetry;

  @override
  State<NoInternetConnection> createState() => _NoInternetConnectionState();
}

class _NoInternetConnectionState extends State<NoInternetConnection> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: <Color>[
            ColorUtils.themeColor,
            const Color(0xFF1E8F87),
            ColorUtils.scaffoldColor,
          ],
          stops: const <double>[0, 0.45, 1],
        ),
      ),
      child: GestureDetector(
        onTap: FocusManager.instance.primaryFocus?.unfocus,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Align(
                  alignment: Alignment.topRight,
                  child: LanguageWidegt(isHome: true),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      final double logoSize = (constraints.maxHeight * 0.12)
                          .clamp(48.0, 80.0);
                      final double cardMaxHeight = (constraints.maxHeight * 0.6)
                          .clamp(240.0, 480.0);

                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                child: Hero(
                                  tag: "register",
                                  child: SvgPicture.asset(
                                    AssetUtils.getSvg("logo"),
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                    height: logoSize,
                                    width: logoSize,
                                  ),
                                ),
                              ),
                              24.heightBox,
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: cardMaxHeight,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 30,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(32),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.08,
                                        ),
                                        blurRadius: 40,
                                        offset: const Offset(0, 12),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/icons/no-wi-fi.png",
                                        height: 80,
                                      ),
                                      24.heightBox,
                                      Text(
                                        "oops".tr,
                                        style:
                                            StyleUtils.kTextStyleSize24Weight600(
                                              color: ColorUtils.themeColor,
                                            ),
                                      ),
                                      10.heightBox,
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 2,
                                        ),
                                        child: Text(
                                          "no_internet_message".tr,
                                          textAlign: TextAlign.center,
                                          style:
                                              StyleUtils.kTextStyleSize14Weight400(
                                                color: ColorUtils.black
                                                    .withValues(alpha: 0.5),
                                              ),
                                        ),
                                      ),
                                      32.heightBox,
                                      GradientButton(
                                        text: "try_again".tr,
                                        onClick: widget.onRetry,
                                      ),
                                      16.heightBox,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
