part of super_nav_bar_lib;

class SuperNavigationBar extends StatelessWidget {
  final IndexedWidgetBuilder tabBuilder;
  final TabController? tabController;
  final NavBarController? navBarController;
  final int? length;
  final EdgeInsets? margin;
  final NavBarEssentials? navBarEssentials;
  final NavBarDecoration? decoration;
  final NavBarStyle? navBarStyle;
  const SuperNavigationBar(
      {Key? key,
      required this.tabBuilder,
      this.tabController,
      this.navBarController,
      this.length,
      this.margin,
      this.navBarEssentials,
      this.decoration,
      this.navBarStyle})
      : super(key: key);

  Widget _getBadgeTabBuilderItem(
      NavBarStyle? style, BuildContext context, int index) {
    late badges.BadgePosition badgePosition;
    if (navBarStyle == NavBarStyle.style1 ||
        navBarStyle == NavBarStyle.style3 || navBarStyle == NavBarStyle.style2 ||
        navBarStyle == NavBarStyle.style4) {
      badgePosition = badges.BadgePosition.topEnd(top: 0, end: -15);
    } else if (navBarStyle == NavBarStyle.style_v1 ||
        navBarStyle == NavBarStyle.style_v2) {
      badgePosition = badges.BadgePosition.topEnd(top: 13, end: -15);
    } else if (navBarStyle == NavBarStyle.neumorphic ||
        navBarStyle == NavBarStyle.sunshine) {
      badgePosition = badges.BadgePosition.topEnd(top: 0, end: -15);
    }
    else {
      badgePosition = badges.BadgePosition.topEnd();
    }
    return ViewModelBuilder<BadgeViewModel>.reactive(
      viewModelBuilder: () => navBarController!.getViewModelWithIndex(index),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, badgeViewModel, child) => badges.Badge(
        position: badgePosition,
        showBadge: badgeViewModel.count > 0 ? true : false,
        badgeContent:
            Text(badgeViewModel.count.toString(), style: TextStyle(color: Colors.white, fontSize: 8)),
        child: Container(
          margin: EdgeInsets.only(top: 0),
          constraints:
              BoxConstraints(minWidth: 65, minHeight: 20, maxWidth: 100),
          child: Center(child: tabBuilder(context, index)),
        ),
      ),
    );
  }

  Widget _tabBarItem(
    BuildContext context,
    int index,
  ) {
    List<Widget> v;
    if (navBarStyle == NavBarStyle.style1 ||
        navBarStyle == NavBarStyle.style3) {
      v = [
        _getBadgeTabBuilderItem(navBarStyle, context, index),
        SizedBox(
          width: 30,
        ),
        VerticalDivider()
      ];
    } else if (navBarStyle == NavBarStyle.style2 ||
        navBarStyle == NavBarStyle.style4) {
      v = [_getBadgeTabBuilderItem(navBarStyle, context, index)];
    } else if (navBarStyle == NavBarStyle.neumorphic) {
      v = [
        Container(
            //1.
            // margin: EdgeInsets.only(top: 0),
            // constraints:
            //     BoxConstraints(minWidth: 65, minHeight: 20, maxWidth: 100),
            // child: Align(alignment: Alignment.center,child: tabBuilder(context, index)),
            //2.
            // padding: EdgeInsets.only(top: 5),
            // constraints:
            //     BoxConstraints(minWidth: 85, minHeight: 30, maxWidth: 100),
            // child: tabBuilder(
            //     context, index)
            //3.
            child: _getBadgeTabBuilderItem(navBarStyle, context, index))
      ];
    } else if (navBarStyle == NavBarStyle.sunshine) {
      v = [
        Container(
          margin: EdgeInsets.only(top: 0),
          constraints:
              BoxConstraints(minWidth: 65, minHeight: 20, maxWidth: 100),
          child: Center(
            child: _getBadgeTabBuilderItem(navBarStyle, context, index)),
        )
      ];
    } else if (navBarStyle == NavBarStyle.style_v1 ||
        navBarStyle == NavBarStyle.style_v2) {
      v = [
        _getBadgeTabBuilderItem(navBarStyle, context, index),
      ];
    } else {
      v = [
        tabBuilder(context, index),
      ];
    }
    return Tab(
      child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: v,
          ),
          decoration: BoxDecoration().superBoxDecoration(
              style: navBarStyle,
              selected: navBarEssentials!.selectedIndex == index)),
    );
  }

  Widget _navBarWidget(BuildContext context) {
    List<Widget> _tabs =
        List.generate(length!, (value) => _tabBarItem(context, value));
    final Future<String> _calculation = Future<String>.delayed(
      const Duration(seconds: 0),
      () {
        return 'getTabBarbgImage..';
      },
    );

    ScrollController scrollController = ScrollController();
    final DividerThemeData dividerTheme = DividerTheme.of(context);
    return Padding(
        padding: this.margin!,
        child: Container(
          child: SafeArea(
            top: false,
            child: DividerTheme(
              data: DividerThemeData(
                  color: navBarEssentials?.splitLineColor,
                  space: 0,
                  indent: 10,
                  endIndent: 10),
              child: Container(
                //可配置
                padding: NavBarPadding.cover(navBarEssentials?.padding),
                decoration: getNavBarDecoration(
                  opacity: 1,
                  decoration: this.decoration,
                  color: this.navBarEssentials!.backgroundColor,
                ),
                height: this.navBarEssentials!.navBarHeight,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    NotificationListener(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollUpdateNotification &&
                              scrollNotification.depth == 0) {
                            scrollController.position
                                .forcePixels(scrollNotification.metrics.pixels);
                            //scrollController.jumpTo(scrollNotification.metrics.pixels);
                            print(scrollNotification.metrics.pixels);
                          }
                          return false;
                        },
                        child: FutureBuilder<String>(
                            future: _calculation,
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (navBarStyle == null) {
                                return TabBar(
                                  tabs: _tabs,
                                  isScrollable: true, //允许左右滚动
                                  controller: tabController,
                                  unselectedLabelColor: Colors
                                      .grey, //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
                                  unselectedLabelStyle: TextStyle(
                                      fontSize:
                                          15), //设置未选中时的字体样式，tabs里面的字体样式优先级最高
                                  labelColor: Colors.black, //设置选中时的字体颜色，
                                  labelStyle: TextStyle(fontSize: 15.0),
                                  indicator: BoxDecoration(), //用于设定选中状态下的展示样式
                                );
                              } else if (navBarStyle == NavBarStyle.style1 ||
                                  navBarStyle == NavBarStyle.style3) {
                                return TabBar(
                                  tabs: _tabs,
                                  isScrollable: true, //允许左右滚动
                                  //labelPadding: EdgeInsets.only(left: 10,right: 10),
                                  controller: tabController,
                                  unselectedLabelColor: navBarEssentials
                                      ?.unselectedLabelColor, //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
                                  unselectedLabelStyle: navBarEssentials
                                      ?.unselectedLabelStyle, //设置未选中时的字体样式，tabs里面的字体样式优先级最高
                                  labelColor: navBarEssentials
                                      ?.labelColor, //设置选中时的字体颜色，
                                  labelStyle: navBarEssentials?.labelStyle,
                                  indicatorColor: navBarEssentials
                                      ?.indicatorColor, //选中下划线的颜色
                                  indicatorSize: TabBarIndicatorSize
                                      .label, //选中下划线的长度，label时跟文字内容长度一样，tab时跟一个Tab的长度一样
                                  indicatorWeight: 2.0,
                                  indicatorPadding: EdgeInsets.only(
                                      right: 30), //选中下划线的高度，值越大高度越高，默认为2。0
                                  // indicator: BoxDecoration(), //用于设定选中状态下的展示样式
                                );
                              } else if (navBarStyle == NavBarStyle.style2 ||
                                  navBarStyle == NavBarStyle.style4) {
                                return TabBar(
                                  tabs: _tabs,
                                  isScrollable: true, //允许左右滚动
                                  controller: tabController,
                                  unselectedLabelColor: navBarEssentials
                                      ?.unselectedLabelColor, //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
                                  unselectedLabelStyle: navBarEssentials
                                      ?.unselectedLabelStyle, //设置未选中时的字体样式，tabs里面的字体样式优先级最高
                                  labelColor: navBarEssentials
                                      ?.labelColor, //设置选中时的字体颜色，
                                  labelStyle: navBarEssentials?.labelStyle,
                                  indicatorColor: navBarEssentials
                                      ?.indicatorColor, //选中下划线的颜色
                                  indicatorSize: TabBarIndicatorSize
                                      .label, //选中下划线的长度，label时跟文字内容长度一样，tab时跟一个Tab的长度一样
                                  indicatorWeight: 2.0,
                                );
                              } else if (navBarStyle ==
                                  NavBarStyle.neumorphic) {
                                return TabBar(
                                  tabs: _tabs,
                                  isScrollable: true, //允许左右滚动
                                  controller: tabController,
                                  unselectedLabelColor: navBarEssentials
                                      ?.unselectedLabelColor, //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
                                  unselectedLabelStyle: navBarEssentials
                                      ?.unselectedLabelStyle, //设置未选中时的字体样式，tabs里面的字体样式优先级最高
                                  labelColor: navBarEssentials
                                      ?.labelColor, //设置选中时的字体颜色，
                                  labelStyle: navBarEssentials?.labelStyle,
                                  indicator: NavBarNeumorphicIndicator(
                                      indicatorHeight: 30,
                                      indicatorColor:
                                          SuperFoodMenuTheme.of(context)
                                              .primaryColor,
                                      tabBarIndicatorSize: TabBarIndicatorSize
                                          .tab), //用于设定选中状态下的展示样式
                                );
                              } else if (navBarStyle == NavBarStyle.sunshine) {
                                return TabBar(
                                  tabs: _tabs,
                                  isScrollable: true, //允许左右滚动
                                  controller: tabController,
                                  unselectedLabelColor: navBarEssentials
                                      ?.unselectedLabelColor, //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
                                  unselectedLabelStyle: navBarEssentials
                                      ?.unselectedLabelStyle, //设置未选中时的字体样式，tabs里面的字体样式优先级最高
                                  labelColor: navBarEssentials
                                      ?.labelColor, //设置选中时的字体颜色，
                                  labelStyle: navBarEssentials?.labelStyle,
                                  indicator: NavBarNeumorphicIndicator(
                                      indicatorColor:
                                          SuperFoodMenuTheme.of(context)
                                              .primaryColor,
                                      indicatorHeight: 40,
                                      tabBarIndicatorSize:
                                          TabBarIndicatorSize.label,
                                      indicatorRadius: 0,
                                      showBeautyNevus: true),
                                );
                              } else if (navBarStyle == NavBarStyle.style_v1) {
                                return VTabBar(
                                    tabs: _tabs,
                                    isScrollable: true, //允许左右滚动
                                    //labelPadding: EdgeInsets.only(left: 10,right: 10),
                                    controller: tabController,
                                    unselectedLabelColor: navBarEssentials
                                        ?.unselectedLabelColor, //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
                                    unselectedLabelStyle: navBarEssentials
                                        ?.unselectedLabelStyle, //设置未选中时的字体样式，tabs里面的字体样式优先级最高
                                    labelColor: navBarEssentials
                                        ?.labelColor, //设置选中时的字体颜色，
                                    labelStyle: navBarEssentials?.labelStyle,
                                    indicatorColor:
                                        navBarEssentials?.indicatorColor,
                                    indicator: VUnderlineTabIndicator(
                                        indicatorHeight:
                                            navBarEssentials!.navBarHeight!,
                                        indicatorColor:
                                            SuperFoodMenuTheme.of(context)
                                                .primaryColor,
                                        tabBarIndicatorSize:
                                            TabBarIndicatorSize.tab,
                                        showBeautyNevus: true));
                              } else if (navBarStyle == NavBarStyle.style_v2) {
                                return VTabBar(
                                    tabs: _tabs,
                                    isScrollable: true, //允许左右滚动
                                    //labelPadding: EdgeInsets.only(left: 10,right: 10),
                                    controller: tabController,
                                    unselectedLabelColor: navBarEssentials
                                        ?.unselectedLabelColor, //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
                                    unselectedLabelStyle: navBarEssentials
                                        ?.unselectedLabelStyle, //设置未选中时的字体样式，tabs里面的字体样式优先级最高
                                    labelColor: navBarEssentials
                                        ?.labelColor, //设置选中时的字体颜色，
                                    labelStyle: navBarEssentials?.labelStyle,
                                    indicatorColor:
                                        navBarEssentials?.indicatorColor,
                                    indicator: VUnderlineTabIndicator(
                                        indicatorHeight:
                                            navBarEssentials!.navBarHeight!,
                                        indicatorColor:
                                            SuperFoodMenuTheme.of(context)
                                                .primaryColor,
                                        tabBarIndicatorSize:
                                            TabBarIndicatorSize.tab,
                                        showBeautyNevus: true));
                              }
                              return TabBar(
                                tabs: _tabs,
                                isScrollable: true, //允许左右滚动
                                controller: tabController,
                              );
                            })),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) => _navBarWidget(context);
}
