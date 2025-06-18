import 'package:collect/utils/asset_utils.dart';
import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/sized_box_extension.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationView extends StatefulWidget {
  final int selectedIndex;
  const BottomNavigationView({
    super.key,
    this.onItemClick,
    required this.selectedIndex,
  });
  final Function(int)? onItemClick;

  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  final homeMenus = [
    {"title": "home", "icon": "ic_home"},
    {"title": "taskList", "icon": "ic_ride_list"},
    {"title": "user", "icon": "ic_user"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorUtils.whiteColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -5),
            color: ColorUtils.shadowHomeColor,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: List.generate(
          homeMenus.length,
          (index) => Expanded(
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
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AssetUtils.getIcons(icon),
            height: 24,
            width: 24,
            color: isSelected
                ? ColorUtils.themeColor
                : ColorUtils.greyMenuTextColor,
          ),
          4.heightBox,
          Text(
            title,
            style: StyleUtils.kTextStyleSize12Weight400(
              color: isSelected
                  ? ColorUtils.themeColor
                  : ColorUtils.greyMenuTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
