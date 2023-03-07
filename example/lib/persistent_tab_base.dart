part of super_nav_bar_lib;

typedef IndexedInnerWidgetsBuilder = List<Widget> Function(
    BuildContext context, int index, TabController rootController, int pageCount);

typedef NumberOfInnerWidgetsBuilder = int Function(int tabIndex);

class PersistentTabBase extends StatefulWidget {
  final NavBarController? controller;

  final List titles;

  // final List<Widget> page;

  ///tab控制器可监听
  final TabController? tabController;

  ///背景色，默认白色
  final Color? backgroundColor;

  final Color? splitLineColor;

  final Color? unselectedLabelColor;

  final TextStyle? unselectedLabelStyle;

  final Color? labelColor;

  final TextStyle? labelStyle;

  final Color? indicatorColor;

  ///navbar高度
  final double? navBarHeight;

  ///外边距
  final EdgeInsets? margin;

  ///内边距
  final NavBarPadding? padding;

  final bool? confineInSafeArea;

  final NavBarDecoration? decoration;

  ///Callback when page or tab change is detected.
  final ValueChanged<int>? onItemSelected;

  final ValueChanged<NavBarAction>? actionBlock;

  final NavBarStyle? navBarStyle;

  ///Custom navigation bar widget.
  final Widget? customWidget;

  ///在某一种样式下生效的属性设置
  //final NeumorphicProperties? neumorphicProperties;

  ///Returns the context of the selected tab.
  final Function(BuildContext?)? selectedTabPageContext;

  final int? tabCount;

  final BuildContext? context;

  /// The widget item builder that will be used to build item on demand
  final IndexedInnerWidgetsBuilder? itemBuilder;

  final NumberOfInnerWidgetsBuilder? numberOfIndexBuilder;

  const PersistentTabBase(
      {Key? key,
      required this.controller,
      required this.titles,
      // required this.page,
      required this.numberOfIndexBuilder,
      required this.itemBuilder,
      this.tabController,
      this.backgroundColor,
      this.splitLineColor,
      this.unselectedLabelColor,
      this.unselectedLabelStyle,
      this.labelColor,
      this.labelStyle,
      this.indicatorColor,
      this.navBarHeight = kBottomNavigationBarHeight,
      this.margin,
      this.padding,
      this.confineInSafeArea,
      this.decoration,
      this.onItemSelected,
      this.actionBlock,
      this.navBarStyle = NavBarStyle.style1,
      this.customWidget,
      this.selectedTabPageContext,
      this.tabCount = 1,
      this.context})
      : super(key: key);

  @override
  _PersistentTabBaseState createState() => _PersistentTabBaseState();
}

class _PersistentTabBaseState extends State<PersistentTabBase>
    with TickerProviderStateMixin {
  late TabController _tabController;
  // late PageController _pageController;

  late bool _sendScreenContext;
  int? _currentIndex;
  late ShopCartBadgeViewModel shopCartBadgeViewModel;

  List<Widget> pages = [];

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    // _pageController.dispose();
  }

  @override
  void initState() {
    super.initState();

    List<BadgeViewModel> viewModels =
        List.generate(widget.titles.length, (value) {
      BadgeViewModel model = BadgeViewModel();
      model.title = widget.titles[value];
      return model;
    });
    shopCartBadgeViewModel = ShopCartBadgeViewModel();
    widget.controller?.shopCartBadgeChanged = (ShopCartBadgeViewModel model) {
      shopCartBadgeViewModel.count = model.count;
      shopCartBadgeViewModel.price = model.price;
      shopCartBadgeViewModel.updateTitle();
    };

    widget.controller!.badgeViewModels = viewModels;
    if (widget.tabController == null) {
      _tabController = TabController(length: widget.tabCount!, vsync: this);
    }

    for (var i = 0; i < _tabController.length; i++) {
      int childInnerWidgetCount = widget.numberOfIndexBuilder!(i);
      List<Widget> childInner = widget.itemBuilder!(context, i, _tabController,childInnerWidgetCount);
      TabController _childController =
          TabController(length: childInnerWidgetCount, vsync: this);
      UnionInnerTabBarView innerTabView = UnionInnerTabBarView(
          controller: _childController, children: childInner);
      pages.add(innerTabView);
    }

    // _pageController = PageController(
    //   initialPage: 0,
    //   viewportFraction: 1,
    //   keepPage: true,
    // );
    _sendScreenContext = false;
    _tabController.addListener(() {
      if (_tabController.index != _currentIndex) {
        if (widget.onItemSelected != null) {
          _sendScreenContext = true;
        }
        // if (mounted) {
        //   _currentIndex = _tabController.index;
        //  // setState(() => _currentIndex = _tabController.index);
        // }
        _currentIndex = _tabController.index;
        // _pageController.jumpToPage(_currentIndex!);
      }
      if (widget.onItemSelected != null) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          widget.onItemSelected!(_currentIndex!);
        });
      }
    });
  }

  Widget _tab() {
    return Container(
      margin: (widget.navBarStyle == NavBarStyle.style_v1 ||
              widget.navBarStyle == NavBarStyle.style_v2)
          ? EdgeInsets.zero
          : widget.margin,
      child: SuperNavigationBar(
        navBarController: widget.controller,
        navBarStyle: widget.navBarStyle,
        tabController: _tabController,
        margin: EdgeInsets.zero,
        length: widget.tabCount,
        tabBuilder: (BuildContext context, int index) {
          return Text(
            '${widget.titles[index]}',
            textAlign: TextAlign.center,
          );
        },
        navBarEssentials: NavBarEssentials(
            navBarHeight: widget.navBarHeight,
            selectedIndex: _currentIndex,
            previousIndex: 0,
            padding: widget.padding,
            backgroundColor: widget.backgroundColor,
            splitLineColor: widget.splitLineColor,
            unselectedLabelColor: widget.unselectedLabelColor,
            unselectedLabelStyle: widget.unselectedLabelStyle,
            labelColor: widget.labelColor,
            labelStyle: widget.labelStyle,
            indicatorColor: widget.indicatorColor,
            onItemSelected: widget.onItemSelected),
        decoration: widget.decoration,
      ),
    );
  }

  Widget _getMiddleTabBarWidget(NavBarStyle? navBarStyle) {
    if (navBarStyle == NavBarStyle.neumorphic ||
        navBarStyle == NavBarStyle.sunshine) {
      return _tab();
    }
    return Container();
  }

  Widget _getTabBarBodyWidget(NavBarStyle? navBarStyle) {
    _getBody() {
      if (navBarStyle == NavBarStyle.neumorphic ||
          navBarStyle == NavBarStyle.sunshine) {
        return Container();
      } else if (navBarStyle == NavBarStyle.style_v1) {
        return Positioned(
            left: 0,
            top: 80,
            bottom: 70,
            width: widget.navBarHeight,
            child: _tab());
      } else if (navBarStyle == NavBarStyle.style_v2) {
        return Stack(
          children: [
            Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: widget.navBarHeight,
                child: _tab()),
            Positioned(
                left: 0,
                height: 200,
                bottom: 0,
                width: widget.navBarHeight,
                child: VTabFooterView(
                    viewModel: shopCartBadgeViewModel,
                    actionBlock: widget.actionBlock)),
          ],
        );
      } else {
        return Positioned.directional(
          textDirection: TextDirection.ltr,
          child: _tab(),
          start: 0,
          top: 74,
          end: 0,
          height: 44,
        );
      }
    }

    // List<Widget> pages = [];
    // for (var i = 0; i < _tabController.length; i++) {
    //   List<Widget> childInner = widget.itemBuilder!(context, i, _tabController);
    //   int childInnerWidgetCount = widget.numberOfIndexBuilder!(i);
    //   TabController _childController =
    //       TabController(length: childInnerWidgetCount, vsync: this);
    //   UnionInnerTabBarView innerTabView = UnionInnerTabBarView(
    //       controller: _childController, children: childInner);
    //   pages.add(innerTabView);
    // }
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
              child: UnionOuterTabBarView(
            controller: _tabController,
            children: pages,
          )
              // PageView(
              //   scrollDirection: Axis.horizontal,
              //   reverse: false,
              //   controller: _pageController,
              //   physics: BouncingScrollPhysics(),
              //   pageSnapping: true,
              //   onPageChanged: (index) {
              //     //监听事件
              //     print('index=====$index');
              //     _tabController.animateTo(index);
              //   },
              //   children: widget.page,
              // ),
              ),
        ),
        _getBody()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: TransparentCupertinoNavigationBar(
        leading: NavBarLeading(navBarDecoration: widget.decoration), // 右侧组件
        trailing: NavBarTrailingView(
          style: widget.navBarStyle,
          viewModel: shopCartBadgeViewModel,
          actionBlock: widget.actionBlock,
        ),
        //backgroundColor: Colors.red,
        border: Border(bottom: BorderSide(color: Colors.transparent)),
        padding: EdgeInsetsDirectional.only(start: 25, bottom: 0, end: 25),
        middle: _getMiddleTabBarWidget(widget.navBarStyle),
      ),
      child: Container(
        decoration: this.widget.controller?.globalBookBgImage == null ||
                this.widget.controller?.globalBookBgImage?.length == 0
            ? BoxDecoration(color: this.widget.backgroundColor ?? Colors.white)
            : BoxDecoration(
                color: this.widget.backgroundColor,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      this.widget.controller!.globalBookBgImage!)
                    ..evict(),
                  //图片填充方式
                  fit: BoxFit.cover,
                  //图片位置
                  alignment: Alignment.topCenter,
                  //图片平铺方式
                  repeat: ImageRepeat.repeatY,
                ),
              ),
        child: _getTabBarBodyWidget(widget.navBarStyle),
      ),
    );
  }
}
