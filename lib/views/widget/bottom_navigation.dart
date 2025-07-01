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
    <String, String>{"title": "taskList", "icon": "ic_ride_list"},
    <String, String>{"title": "user", "icon": "ic_user"},
  ];

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: ColorUtils.themeColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          offset: const Offset(1, -5),
          color: ColorUtils.scaffoldColor,
          blurRadius: 5,
        ),
      ],
    ),
    child: Row(
      children: List.generate(
        homeMenus.length,
        (int index) => Expanded(
          child: InkWell(
            onTap: () {
              widget.onItemClick?.call(index);
            },
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
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),

    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          AssetUtils.getIcons(icon),
          height: 24,
          width: 24,
          color: isSelected
              ? ColorUtils.whiteColor
              : ColorUtils.greyLightTextColor,
        ),
        4.heightBox,
        Text(
          title,
          style: StyleUtils.kTextStyleSize12Weight400(
            color: isSelected
                ? ColorUtils.whiteColor
                : ColorUtils.greyMenuTextColor,
          ),
        ),
      ],
    ),
  );
}
