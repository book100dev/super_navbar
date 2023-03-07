import 'package:example/super_nav_bar_lib.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const DeviceHomeMenuWidget(),
    );
  }
}

class DeviceHomeMenuWidget extends StatefulWidget {
  const DeviceHomeMenuWidget({Key? key}) : super(key: key);

  @override
  _DeviceHomeMenuWidgetState createState() => _DeviceHomeMenuWidgetState();
}

class _DeviceHomeMenuWidgetState extends State<DeviceHomeMenuWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  NavBarController navBarController = NavBarController();
  late List titles;
  @override
  void initState() {
    super.initState();
    titles = [
      '热菜',
      '推荐菜品',
      '马卡龙十点多',
      '就算',
      '精品套餐',
      '马卡龙',
      '就ss',
      '胡好久品套餐',
      '叔叔是多少',
      'v1',
      'v2',
      'v3',
      'v4',
      'v5',
      'v6',
      'v7',
      'v8',
      'v9',
      'v10',
    ];
    _tabController = TabController(length: titles.length, vsync: this);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    navBarController.globalBookBgImage =
        'http://cd7.okayapi.com/821D019A12A2E8C7200D4FE7E27A54EA_20220219181014_c92c568c083faa894938adee96a92292.jpg';
    print('aaaa');
    if (_tabController == null) {
      return Container();
    }
    NavBarStyle navBarStyle = NavBarStyle.style1;
    //NavBarStyle navBarStyle = s;

    NavBarPadding _barpadding;
    if (navBarStyle == NavBarStyle.style_v1) {
      _barpadding = NavBarPadding.only(top: 30, bottom: 30);
    } else if (navBarStyle == NavBarStyle.style_v2) {
      _barpadding = NavBarPadding.only(top: 74, bottom: 200);
    } else {
      _barpadding = NavBarPadding.only(left: 0, right: 0);
    }
    List<Widget> pages = List.generate(
        titles.length,
        (value) => Center(
                child: Text(
              titles[value],
              style: TextStyle(color: Colors.white),
            )));
    return Scaffold(
      //backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context)
            .size
            .height), //SuperNavigationUtils.sizeFromNavBarStyle(navBarStyle),
        child: PersistentTabBase(
          key: UniqueKey(),
          context: context,
          controller: navBarController,
          numberOfIndexBuilder: (int tabIndex) {
            return 1;
          },
          itemBuilder: (BuildContext context, int index,
              TabController childController, int pageCount) {
            List<Widget> pages = [Container()];
            return pages;
          },
          onItemSelected: (int index) {
            print('回调 $index');
            // Future.delayed(Duration(milliseconds: 2000), () {
            //   print("延时1秒执行");
            //   navBarController.updateBadgeOnCurrentTitle(1, index);

            //   navBarController.updateShopCartBadgeView(2, '14');
            // });
          },
          actionBlock: (NavBarAction action) {
            if (action == NavBarAction.search) {
              print('搜索按钮');
            } else if (action == NavBarAction.shopCart) {
              print('进入购物车');
            } else if (action == NavBarAction.logout) {
              print('退出');
            }
          },
          //tabController: TabController(length: titles.length, vsync: this),
          titles: titles,
          // page: pages,
          tabCount: titles.length,
          navBarHeight: (navBarStyle == NavBarStyle.style_v1 ||
                  navBarStyle == NavBarStyle.style_v2)
              ? 140
              : 44,
          // margin: EdgeInsets.only(top: 10, right: 10),
          padding: _barpadding,
          backgroundColor: Colors.red,
          // splitLineColor: HexColor.fromHex(widget.bookConfig!.splitLineColor!),
          // unselectedLabelColor: HexColor.fromHex(
          //     widget.bookConfig?.unselectedLabelColor ??
          //         '720000'), //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
          // unselectedLabelStyle:
          //     TextStyle(fontSize: 15), //设置未选中时的字体样式，tabs里面的字体样式优先级最高
          // labelColor:
          //     HexColor.fromHex(widget.bookConfig!.labelColor!), //设置选中时的字体颜色，
          // labelStyle: TextStyle(fontSize: 15.0),
          // indicatorColor:
          //     HexColor.fromHex(widget.bookConfig!.indicatorColor!), //选中下划
          navBarStyle: navBarStyle,
          decoration:
              // NavBarDecoration(
              //     imagePath: 'https://img3.chouti.com/CHOUTI_20210809/1D61299B35B74D908B4629D622B227A4_W711H711.jpeg',
              //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
              //     border: Border.all(width: 1, color: Colors.red)),

              //---
              NavBarDecoration(
            imagePath:
                'https://img3.chouti.com/CHOUTI_220219_B9F6255C94AD4068BF274818D891AA37.jpeg?imageView2/1/q',
            logoUrl: 'https://dig.chouti.com/images/logo-c30a1a3941.png',
            border: (navBarStyle == NavBarStyle.style_v1 ||
                    navBarStyle == NavBarStyle.style_v2)
                ? null
                : Border.symmetric(
                    horizontal: BorderSide(
                        color: SuperFoodMenuTheme.of(context).primaryColor,
                        width: 2)),
            //     boxShadow: [
            //   BoxShadow(
            //       // 设置第一个阴影效果
            //       color: Colors.green, // 阴影颜色为绿色
            //       offset: Offset(2, 1),
            //       blurRadius: 1, // 模糊半径为10
            //       spreadRadius: 1), // 延伸半径为10
            // ]
          ),

          // NavBarDecoration(
          //     imagePath:
          //         'https://img3.chouti.com/CHOUTI_20210809/1D61299B35B74D908B4629D622B227A4_W711H711.jpeg',
          //     border: Border.symmetric(
          //         vertical: BorderSide(color: Colors.white, width: 2))),

          // NavBarDecoration(
          //     imagePath:
          //         'https://img3.chouti.com/CHOUTI_20210809/1D61299B35B74D908B4629D622B227A4_W711H711.jpeg',
          //     border: Border(
          //       top: BorderSide(color: Colors.pink, width: 3), // 上边边框
          //       right: BorderSide(color: Colors.green, width: 4), // 右侧边框
          //       bottom: BorderSide(color: Colors.yellow, width: 5), // 底部边框
          //       left: BorderSide(color: Colors.cyan, width: 6), // 左侧边框
          //     )),
        ),
      ),
      //body: Center(child: Text('ss'),),
    );
  }
}
