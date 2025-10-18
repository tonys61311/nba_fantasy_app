import 'package:flutter/material.dart';
import 'package:nba_fantasy_app/core/enum/bottom_nav_item.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.currentItem, this.onChanged, required this.pageController});

  final BottomNavItem currentItem;
  final ValueChanged<BottomNavItem>? onChanged;
  final PageController pageController;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  double _page = 0;

  @override
  void initState() {
    super.initState();
    _page = widget.pageController.initialPage.toDouble();
    widget.pageController.addListener(_onPageChanged);
  }

  @override
  void didUpdateWidget(covariant BottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pageController != widget.pageController) {
      oldWidget.pageController.removeListener(_onPageChanged);
      _page = widget.pageController.page ?? widget.pageController.initialPage.toDouble();
      widget.pageController.addListener(_onPageChanged);
    }
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_onPageChanged);
    super.dispose();
  }

  void _onPageChanged() {
    final double p = widget.pageController.page ?? widget.pageController.initialPage.toDouble();
    if (p != _page) {
      setState(() {
        _page = p;
      });
    }
  }

  void _handleTap(BottomNavItem item) {
    widget.onChanged?.call(item);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final int itemCount = BottomNavItem.barItems.length;
        final double fullWidth = constraints.maxWidth;
        final double segmentWidth = fullWidth / itemCount;
        final double indicatorWidth = segmentWidth * 0.9;
        final double clampedPage = _page.clamp(0, (itemCount - 1).toDouble());
        final double indicatorLeft = clampedPage * segmentWidth + (segmentWidth - indicatorWidth) / 2;

        return Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            BottomNavigationBar(
              currentIndex: widget.currentItem.getIndexInItems,
              selectedItemColor: theme.colorScheme.primary,
              unselectedItemColor: theme.unselectedWidgetColor,
              // Slightly elevated/lighter surface for the nav bar background
              backgroundColor: theme.colorScheme.surfaceContainerLow,
              selectedLabelStyle: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
              unselectedLabelStyle: theme.textTheme.labelMedium,
              type: BottomNavigationBarType.fixed,
              onTap: (index) => _handleTap(BottomNavItem.getItemFromIndex(index)),
              items: BottomNavItem.barItems.map((item) {
                final bool isActive = item == widget.currentItem;
                final Color activeColor = theme.colorScheme.primary;
                final Color inactiveColor = theme.unselectedWidgetColor;
                return BottomNavigationBarItem(
                  icon: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isActive ? activeColor.withOpacity(0.12) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(item.icon, color: isActive ? activeColor : inactiveColor),
                  ),
                  label: item.title,
                );
              }).toList(),
            ),
            // Underline indicator that follows the page position
            Positioned(
              top: 0,
              left: indicatorLeft,
              width: indicatorWidth,
              child: IgnorePointer(
                ignoring: true,
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
