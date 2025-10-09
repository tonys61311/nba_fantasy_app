import 'package:flutter/material.dart';

class TabItem {
  final String id;
  final String name;
  const TabItem({required this.id, required this.name});
}

class ModelTabBar extends StatefulWidget {
  const ModelTabBar({
    super.key,
    required this.tabs,
    this.activeId,
    this.onTabSelected,
    this.activeColor,
    this.inactiveColor,
    this.indicatorColor,
    this.indicatorHeight = 3,
    this.animationDuration = const Duration(milliseconds: 250),
  });

  final List<TabItem> tabs;
  final String? activeId;
  final ValueChanged<String>? onTabSelected;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? indicatorColor;
  final double indicatorHeight;
  final Duration animationDuration;

  @override
  State<ModelTabBar> createState() => _ModelTabBarState();
}

class _ModelTabBarState extends State<ModelTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  int get _activeIndex {
    if (widget.activeId == null) return _controller.index;
    final idx = widget.tabs.indexWhere((t) => t.id == widget.activeId);
    return idx >= 0 ? idx : 0;
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.tabs.length, vsync: this);
    // 初始化對齊 activeId
    final idx = _activeIndex;
    if (idx != 0) {
      _controller.index = idx;
    }
  }

  @override
  void didUpdateWidget(covariant ModelTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabs.length != widget.tabs.length) {
      _controller.dispose();
      _controller = TabController(length: widget.tabs.length, vsync: this);
    }
    final target = _activeIndex;
    if (_controller.index != target) {
      _controller.animateTo(target,
          duration: widget.animationDuration, curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final activeColor = widget.activeColor ?? colorScheme.onPrimary;
    final inactiveColor =
        widget.inactiveColor ?? colorScheme.onSurface.withOpacity(0.6);
    final indicatorColor = widget.indicatorColor ?? colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        controller: _controller,
        isScrollable: false,
        labelColor: activeColor,
        unselectedLabelColor: inactiveColor,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: indicatorColor,
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorPadding: EdgeInsets.zero,
        indicatorSize: TabBarIndicatorSize.tab,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        tabs: widget.tabs
            .map((t) => Tab(
                  height: 40,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      t.name,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ))
            .toList(),
        onTap: (index) {
          _controller.animateTo(index,
              duration: widget.animationDuration, curve: Curves.easeInOut);
          final selected = widget.tabs[index];
          widget.onTabSelected?.call(selected.id);
        },
      ),
    );
  }
}


