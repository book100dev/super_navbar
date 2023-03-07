part of super_nav_bar_lib;

class NavBarEssentials {
  final int? selectedIndex;
  final int? previousIndex;
  final Color? backgroundColor;
  final Color? splitLineColor;
  final Color? unselectedLabelColor;
  final TextStyle? unselectedLabelStyle;
  final Color? labelColor;
  final TextStyle? labelStyle;
  final Color? indicatorColor;
  //final List<PersistentBottomNavBarItem>? items;
  final ValueChanged<int>? onItemSelected;
  final double? navBarHeight;
  final NavBarPadding? padding;
  final bool? popScreensOnTapOfSelectedTab;
  //final ItemAnimationProperties? itemAnimationProperties;
  final BuildContext? selectedScreenBuildContext;

  const NavBarEssentials({
    Key? key,
    this.selectedIndex,
    this.previousIndex,
    this.backgroundColor,
    this.splitLineColor,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.labelColor,
    this.labelStyle,
    this.indicatorColor,
    this.popScreensOnTapOfSelectedTab,
    //this.itemAnimationProperties,
    this.navBarHeight = 0.0,
    //required this.items,
    this.onItemSelected,
    this.padding,
    this.selectedScreenBuildContext,
  });

  NavBarEssentials copyWith({
    int? selectedIndex,
    int? previousIndex,
    double? iconSize,
    Color? backgroundColor,
    Color? splitLineColor,
    //List<PersistentBottomNavBarItem>? items,
    ValueChanged<int>? onItemSelected,
    double? navBarHeight,
    NavBarPadding? padding,
    Function(int)? popAllScreensForTheSelectedTab,
    bool? popScreensOnTapOfSelectedTab,
    // ItemAnimationProperties? itemAnimationProperties,
  }) {
    return NavBarEssentials(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      previousIndex: previousIndex ?? this.previousIndex,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      splitLineColor: splitLineColor ?? this.splitLineColor,
      //items: items ?? this.items,
      onItemSelected: onItemSelected ?? this.onItemSelected,
      navBarHeight: navBarHeight ?? this.navBarHeight,
      padding: padding ?? this.padding,
      popScreensOnTapOfSelectedTab:
          popScreensOnTapOfSelectedTab ?? this.popScreensOnTapOfSelectedTab,
      // itemAnimationProperties:
      //     itemAnimationProperties ?? this.itemAnimationProperties,
    );
  }
}
