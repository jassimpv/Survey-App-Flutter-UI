import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/theme/theme_service.dart";
import "package:collect/core/utils/sized_box_extension.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({
    required this.selectedIndex,
    super.key,
    this.onItemClick,
  });
  final int selectedIndex;
  final Function(int)? onItemClick;

  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> homeMenus = [
    {"title": "Home", "icon": CupertinoIcons.home},
    {"title": "Tasks", "icon": CupertinoIcons.list_bullet},
    {"title": "Settings", "icon": CupertinoIcons.settings},
  ];

  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: ThemeColors.bottomNavGradient,
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
                homeMenus.length,
                (int index) => Expanded(
                  child: Center(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => widget.onItemClick?.call(index),
                      child: _Pressable(
                        child: _HomeItemView(
                          title: homeMenus[index]["title"].toString().tr,
                          icon: homeMenus[index]["icon"]!,
                          isSelected: widget.selectedIndex == index,
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

class _Pressable extends StatefulWidget {
  const _Pressable({required this.child});
  final Widget child;

  @override
  State<_Pressable> createState() => _PressableState();
}

class _PressableState extends State<_Pressable> {
  bool _pressed = false;

  void _onPointerDown(PointerDownEvent e) => setState(() => _pressed = true);

  void _onPointerUp(PointerUpEvent e) {
    Future.delayed(const Duration(milliseconds: 80), () {
      if (mounted) setState(() => _pressed = false);
    });
  }

  void _onPointerCancel(PointerCancelEvent e) =>
      setState(() => _pressed = false);

  @override
  Widget build(BuildContext context) => Listener(
    behavior: HitTestBehavior.translucent,
    onPointerDown: _onPointerDown,
    onPointerUp: _onPointerUp,
    onPointerCancel: _onPointerCancel,
    child: AnimatedScale(
      scale: _pressed ? 0.96 : 1.0,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: widget.child,
    ),
  );
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
          boxShadow: isSelected
              ? <BoxShadow>[
                  BoxShadow(
                    color: ThemeColors.blackColor.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
          border: isSelected ? Border.all(color: ThemeColors.border) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? ThemeColors.themeColor
                  : ThemeColors.whiteColor.withValues(alpha: 0.9),
            ),
            if (isSelected) ...[
              10.widthBox,
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: StyleUtils.kTextStyleSize14Weight600(
                    color: ThemeColors.themeColor,
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
