import "package:collect/utils/asset_utils.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/sized_box_extension.dart";
import "package:collect/utils/textstyle_input.dart";
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

class _BottomNavigationViewState extends State<BottomNavigationView> {
  final List<Map<String, String>> homeMenus = <Map<String, String>>[
    <String, String>{"title": "home", "icon": "ic_home"},
    <String, String>{"title": "collectionReport", "icon": "ic_ride_list"},
    <String, String>{"title": "user", "icon": "ic_user"},
  ];

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.only(
      left: 20,
      right: 20,
      top: 12,
      bottom: MediaQuery.viewPaddingOf(context).bottom,
    ),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          ColorUtils.themeColor.withValues(alpha: 0.9),
          ColorUtils.themeColor,
        ],
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          offset: const Offset(0, -6),
          color: ColorUtils.themeColor.withValues(alpha: 0.25),
          blurRadius: 20,
        ),
      ],
    ),
    child: Row(
      children: List.generate(
        homeMenus.length,
        (int index) => Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => widget.onItemClick?.call(index),
            child: _HomeItemView(
              title: homeMenus[index]["title"].toString().tr,
              icon: homeMenus[index]["icon"]!,
              isSelected: widget.selectedIndex == index,
            ),
          ),
        ),
      ),
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
  final String icon;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    curve: Curves.easeOut,
    margin: const EdgeInsets.symmetric(horizontal: 6),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: isSelected
          ? Colors.white.withValues(alpha: 0.15)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      border: isSelected
          ? Border.all(color: Colors.white.withValues(alpha: 0.3))
          : null,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          AssetUtils.getIcons(icon),
          height: 24,
          width: 24,
          color: isSelected ? Colors.white : ColorUtils.greyLightTextColor,
        ),
        6.heightBox,
        Text(
          title,
          textAlign: TextAlign.center,
          style: StyleUtils.kTextStyleSize12Weight600(
            color: isSelected ? Colors.white : ColorUtils.greyMenuTextColor,
          ),
        ),
      ],
    ),
  );
}
