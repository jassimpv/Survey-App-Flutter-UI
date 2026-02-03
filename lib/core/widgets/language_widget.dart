import 'package:collect/core/theme/theme_colors.dart';
import 'package:collect/core/utils/textstyle_input.dart';
import 'package:collect/core/utils/transaltion_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageWidegt extends StatefulWidget {
  const LanguageWidegt({super.key, this.isHome = false});
  final bool isHome;

  @override
  State<LanguageWidegt> createState() => _LanguageWidegtState();
}

class _LanguageWidegtState extends State<LanguageWidegt>
    with SingleTickerProviderStateMixin {
  late bool _isEnglish;
  bool _inFlight = false;

  @override
  void initState() {
    super.initState();
    _isEnglish = Get.locale?.languageCode == 'en';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // keep in sync if locale changed externally
    _isEnglish = Get.locale?.languageCode == 'en';
  }

  Future<void> _toggle() async {
    if (_inFlight) return;
    setState(() {
      _isEnglish = !_isEnglish;
      _inFlight = true;
    });

    try {
      if (_isEnglish) {
        await TranslationService.updateLocale(const Locale('en', 'US'));
      } else {
        await TranslationService.updateLocale(const Locale('ar', 'AE'));
      }
    } catch (_) {
      // revert on error
      setState(() {
        _isEnglish = !_isEnglish;
      });
    } finally {
      setState(() {
        _inFlight = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double width = 72;
    const double height = 36;

    return Semantics(
      button: true,
      label: _isEnglish ? 'Language: English' : 'Language: Arabic',
      hint: 'Tap to switch language',
      child: GestureDetector(
        onTap: _toggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInOut,
          width: width,
          height: height,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: ThemeColors.whiteColor.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: ThemeColors.themeColor.withValues(alpha: 0.10),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: ThemeColors.shadow,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // subtle text indicator: selected label on its side, animated opacity
              Positioned.fill(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // // EN on the left
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 220),
                        opacity: 1.0,
                        curve: Curves.easeInOut,
                        child: Text(
                          _isEnglish ? 'EN' : 'AR',
                          style: StyleUtils.kTextStyleLanguageBadge(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Animated flag knob
              AnimatedAlign(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeInOut,
                alignment: _isEnglish
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeInOut,
                  width: height - 8,
                  height: height - 8,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: ThemeColors.whiteColor,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: ThemeColors.shadow,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) =>
                              ScaleTransition(scale: animation, child: child),
                      child: Image.asset(
                        _isEnglish
                            ? 'assets/icons/ic_lang_en.png'
                            : 'assets/icons/ic_lang_ar.png',
                        key: ValueKey<bool>(_isEnglish),
                        width: (height - 12),
                        height: (height - 12),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              if (_inFlight)
                Positioned(
                  right: 6,
                  child: SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ThemeColors.themeColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
