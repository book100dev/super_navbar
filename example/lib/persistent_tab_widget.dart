part of super_nav_bar_lib;

// class PersistentTabWidget extends PersistentTabBase {

//   final List titles;

//   ///tab控制器可监听
//   final TabController? tabController;

//   ///背景色，默认白色
//   final Color? backgroundColor;

//   ///分割线颜色
//   final Color? splitLineColor;

//   final Color? unselectedLabelColor; 

//   final TextStyle? unselectedLabelStyle;

//   final Color? labelColor;

//   final TextStyle? labelStyle;

//   final Color? indicatorColor;

//   ///navbar高度
//   final double? navBarHeight;

//   ///tab外边距 ps： 离 左右控件的距离
//   final EdgeInsets? margin;

//   ///内边距 tabBar 离Tab
//   final NavBarPadding? padding;

//   final bool? confineInSafeArea;

//   final NavBarDecoration? decoration;

//   ///Callback when page or tab change is detected.
//   final ValueChanged<int>? onItemSelected;

//   final NavBarStyle? navBarStyle;

//   ///Custom navigation bar widget.
//   final Widget? customWidget;

//   ///在某一种样式下生效的属性设置
//   //final NeumorphicProperties? neumorphicProperties;

//   ///Returns the context of the selected tab.
//   final Function(BuildContext?)? selectedTabPageContext;

//   final int? tabCount;

//   final BuildContext? context;

//   PersistentTabWidget(
//       {Key? key,
//       required this.titles,
//       this.tabController,
//       this.backgroundColor = Colors.white,
//       this.splitLineColor = Colors.orange,
//       this.unselectedLabelColor = Colors.black,
//       this.unselectedLabelStyle,
//       this.labelColor = Colors.black,
//       this.labelStyle,
//       this.indicatorColor = Colors.red,
//       this.navBarHeight = kBottomNavigationBarHeight,
//       this.margin,
//       this.padding,
//       this.confineInSafeArea,
//       this.decoration,
//       this.onItemSelected,
//       this.navBarStyle,
//       this.customWidget,
//       this.selectedTabPageContext,
//       this.tabCount = 1,
//       this.context})
//       : super(key: key, titles: []);
// }
