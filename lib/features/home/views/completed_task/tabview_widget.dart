import "package:collect/features/home/controller/home_controller.dart";
import "package:collect/core/extensions/auto_scroll/auto_scroll.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class CompletedListTabView extends StatefulWidget {
  const CompletedListTabView({
    required this.onTabSelect,
    super.key,
    this.todaysCount = 0,
    this.completedCount = 0,
    this.upcomingCount = 0,
    this.selectedIndex = 0,
  });
  final Function(int tabIndex) onTabSelect;
  final int todaysCount;
  final int upcomingCount;
  final int completedCount;
  final int selectedIndex;

  @override
  State<CompletedListTabView> createState() => _RideListTabViewState();
}

class _RideListTabViewState extends State<CompletedListTabView> {
  final HomeController controller = Get.find<HomeController>();
  RxInt selectedIndex = 0.obs;
  // ScrollController scrollController = ScrollController();
  final AutoScrollController scrollController = AutoScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedIndex.value = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) => Obx(
    () => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: ThemeColors.scaffoldColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: ThemeColors.themeColor.withValues(alpha: 0.12),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        child: Row(
          spacing: 10,
          children: <Widget>[
            for (int index = 0; index < controller.tabList.length; index++)
              AutoScrollTag(
                key: ValueKey(index),
                controller: scrollController,
                index: index,
                child: TabItem(
                  title:
                      "${controller.tabList[index].toString().tr} (${widget.todaysCount})",
                  isSelected: selectedIndex.value == index,
                  onTap: () {
                    scrollController.scrollToIndex(
                      index,
                      preferPosition: AutoScrollPosition.middle,
                    );
                    selectedIndex.value = index;
                    widget.onTabSelect.call(selectedIndex.value);
                  },
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

class TabItem extends StatelessWidget {
  const TabItem({
    required this.title,
    super.key,
    this.onTap,
    this.isSelected = false,
  });
  final bool isSelected;
  final String title;
  final Function? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => onTap?.call(),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected
              ? ThemeColors.themeColor.withValues(alpha: 0.4)
              : ThemeColors.themeColor.withValues(alpha: 0.2),
        ),
        boxShadow: isSelected
            ? <BoxShadow>[
                BoxShadow(
                  color: ThemeColors.themeColor.withValues(alpha: 0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          title,
          style: StyleUtils.kTextStyleSize14Weight600(
            color: isSelected
                ? ThemeColors.themeColor
                : ThemeColors.themeTextColor,
          ),
        ),
      ),
    ),
  );
}
