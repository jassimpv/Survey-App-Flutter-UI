import "package:collect/controller/home_controller.dart";
import "package:collect/extension/auto_scroll/auto_scroll.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/textstyle_input.dart";
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
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
        color: ColorUtils.whiteColor,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        child: Row(
          spacing: 8,
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
    onTap: () {
      onTap?.call();
    },
    child: Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 5.8),
      decoration: StyleUtils.cardViewSmall(isSelected: isSelected),
      child: Center(
        child: Text(
          title,
          style: StyleUtils.kTextStyleSize14Weight500(
            color: isSelected
                ? ColorUtils.whiteColor
                : ColorUtils.themeTextColor,
          ),
        ),
      ),
    ),
  );
}
