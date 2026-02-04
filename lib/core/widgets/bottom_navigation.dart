import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/theme/theme_service.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class _BottomNavigationController extends GetxController
    with GetTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _scaleAnimation;

  Animation<Offset> get offsetAnimation => _offsetAnimation;
  Animation<double> get opacityAnimation => _opacityAnimation;
  Animation<double> get scaleAnimation => _scaleAnimation;

  final List<Map<String, dynamic>> homeMenus = [
    {"title": "home", "icon": CupertinoIcons.home},
    {"title": "tasks", "icon": CupertinoIcons.list_bullet},
    {"title": "settings", "icon": CupertinoIcons.settings},
  ];

  @override
  void onInit() {
    super.onInit();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 640),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.28),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.96,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    // Slight delay so the nav animates after build
    Future.microtask(() => _controller.forward());
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }
}

class BottomNavigationView extends StatelessWidget {
  BottomNavigationView({
    required this.selectedIndex,
    super.key,
    this.onItemClick,
  });
  final int selectedIndex;
  final Function(int)? onItemClick;
  final controller = Get.put(_BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: controller.offsetAnimation,
      child: FadeTransition(
        opacity: controller.opacityAnimation,
        child: ScaleTransition(
          scale: controller.scaleAnimation,
          child: Container(
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              // color: ThemeService.isDark() ? ThemeColors.surface : null,
              gradient: ThemeService.isDark()
                  ? ThemeColors.surfaceGradient
                  : ThemeColors.bottomNavGradient,
              borderRadius: BorderRadius.circular(28),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: const Offset(0, 10),
                  color: ThemeService.isDark()
                      ? ThemeColors.blackColor.withValues(alpha: 0.4)
                      : ThemeColors.themeColor.withValues(alpha: 0.25),
                  blurRadius: 30,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: List.generate(
                controller.homeMenus.length,
                (int index) => Expanded(
                  child: Center(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => onItemClick?.call(index),
                      child: _Pressable(
                        child: _HomeItemView(
                          title: controller.homeMenus[index]["title"].toString().tr,
                          icon: controller.homeMenus[index]["icon"]!,
                          isSelected: selectedIndex == index,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PressableController extends GetxController {
  final RxBool pressed = false.obs;

  void onPointerDown(PointerDownEvent e) => pressed.value = true;

  void onPointerUp(PointerUpEvent e) {
    Future.delayed(const Duration(milliseconds: 80), () {
      pressed.value = false;
    });
  }

  void onPointerCancel(PointerCancelEvent e) => pressed.value = false;
}

class _Pressable extends StatelessWidget {
  const _Pressable({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(_PressableController());
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: controller.onPointerDown,
      onPointerUp: controller.onPointerUp,
      onPointerCancel: controller.onPointerCancel,
      child: Obx(
        () => AnimatedScale(
          scale: controller.pressed.value ? 0.96 : 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: child,
        ),
      ),
    );
  }
}

class _HomeItemView extends StatelessWidget {
  const _HomeItemView({
    required this.title,
    required this.icon,
    this.isSelected = false,
  });
  final bool isSelected;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 14 : 8,
          vertical: isSelected ? 10 : 8,
        ),
        constraints: BoxConstraints(
          minWidth: isSelected ? 120 : 56,
          maxWidth: isSelected ? 180 : 56,
          minHeight: 48,
        ),
        decoration: BoxDecoration(
          color: isSelected ? ThemeColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          border: isSelected
              ? Border.all(
                  color: ThemeService.isDark()
                      ? ThemeColors.blackWhite.withValues(alpha: 0.3)
                      : ThemeColors.border,
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? ThemeColors.blackWhite
                  : ThemeColors.whiteColor.withValues(alpha: 0.85),
            ),
            if (isSelected) ...[
              10.widthBox,
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: StyleUtils.kTextStyleSize14Weight600(
                    color: ThemeColors.blackWhite,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
