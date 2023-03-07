part of super_nav_bar_lib;

class NavBarTrailingView
    extends ViewModelBuilderWidget<ShopCartBadgeViewModel> {
  final NavBarStyle? style;
  final ValueChanged<NavBarAction>? actionBlock;
  final ShopCartBadgeViewModel viewModel;
  const NavBarTrailingView(
      {Key? key,
      required this.style,
      required this.viewModel,
      this.actionBlock})
      : super(key: key);
  @override
  bool get reactive => true;

  @override
  bool get createNewModelOnInsert => false;

  @override
  bool get disposeViewModel => true;

  @override
  Widget builder(
    BuildContext context,
    ShopCartBadgeViewModel viewModel,
    Widget? child,
  ) {
    Color controlColor = SuperFoodMenuTheme.of(context).primaryColor;
    if (style == NavBarStyle.style_v2) return Container();
    if (style == NavBarStyle.neumorphic || style == NavBarStyle.sunshine) {
      return Container(
          width: 200,
          height: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('共计',
                  style: TextStyle(
                      fontSize: 17,
                      color: controlColor,
                      fontWeight: FontWeight.bold)),
              Text('${viewModel.price}' + '元',
                  style: TextStyle(
                      fontSize: 17,
                      color: controlColor,
                      fontWeight: FontWeight.bold)),
              badges.Badge(
               
                badgeColor: Colors.red,
                child: Container(
                  width: 80,
                  child: TextButton(
                      onPressed: () {
                        if (actionBlock != null) {
                          actionBlock!(NavBarAction.shopCart);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(controlColor),
                          shape: MaterialStateProperty.all(StadiumBorder(
                              side: BorderSide(
                            color: controlColor,
                            style: BorderStyle.solid,
                          )))),
                      child: Text(
                        '已选',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17,
                            color: SuperFoodMenuTheme.of(context)
                                .navBarButonTextColor,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                badgeContent: Text(viewModel.count.toString(),
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: controlColor, width: 2), // 底部边框
          )));
    }
    return Container(
      width: 350,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
              left: 0,
              width: 140,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  if (actionBlock != null) {
                    actionBlock!(NavBarAction.search);
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(controlColor),
                    overlayColor:
                        MaterialStateProperty.all(Colors.green), // 高亮色
                    textStyle: MaterialStateProperty.all(TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)), //字体
                    shape: MaterialStateProperty.all(
                      SuperNavBarOutlinedBorder(style: style, context: context)
                          .bavBarOutlinedBorder,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.manage_search_outlined,
                    ),
                    Text('搜索菜品')
                  ],
                ),
              )),
          Positioned(
              right: 0,
              top: 0,
              width: 200,
              height: 44,
              child: Container(
                decoration:
                    SuperNavBarOutlinedBorder(style: style, context: context)
                        .boxDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () {
                          if (actionBlock != null) {
                            actionBlock!(NavBarAction.shopCart);
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(controlColor),
                            overlayColor:
                                MaterialStateProperty.all(Colors.green), // 高亮色
                            textStyle: MaterialStateProperty.all(TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold)), //字体
                            // // side: MaterialStateProperty.all(
                            // //     BorderSide(width: 1, color: Color(0xff86463f))),
                            shape: MaterialStateProperty.all(
                                SuperNavBarOutlinedBorder(
                                        style: style, context: context)
                                    .bavBarOutlinedBorder)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            badges.Badge(
                          
                              badgeColor: Colors.red,
                              child: Icon(
                                Icons.shopping_cart,
                              ),
                              badgeContent: Text(viewModel.count.toString(),
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Text('${viewModel.price}' + '元',
                                style: TextStyle(
                                  color: Colors.black,
                                ))
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          '已选',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ))
        ],
      ),
    );
  }

  @override
  ShopCartBadgeViewModel viewModelBuilder(BuildContext context) => viewModel;
}

class SuperNavBarOutlinedBorder {
  get bavBarOutlinedBorder => _border;
  get boxDecoration => _box;
  NavBarStyle? style;
  BuildContext? context;
  late OutlinedBorder _border;
  late BoxDecoration _box;
  factory SuperNavBarOutlinedBorder(
      {NavBarStyle? style, BuildContext? context}) {
    return SuperNavBarOutlinedBorder._border(style, context);
  }
  SuperNavBarOutlinedBorder._border(this.style, this.context) {
    Color? color;
    if (context != null) {
      color = SuperFoodMenuTheme.of(context!).primaryColor;
    } else {
      color = Colors.red;
    }
    if (style == NavBarStyle.style1 || style == NavBarStyle.style2) {
      this._border = StadiumBorder(
          side: BorderSide(
        color: color,
        style: BorderStyle.solid,
      ));
      this._box = BoxDecoration(
        color: color,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(22.0)),
        //设置四周边框
        border: Border.all(width: 1, color: color),
      );
    } else if (style == NavBarStyle.style3 || style == NavBarStyle.style4) {
      this._border = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide(
          width: 2,
          color: color,
          style: BorderStyle.solid,
        ),
      );
      this._box = BoxDecoration(
        color: color,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
        //设置四周边框
        border: Border.all(width: 1, color: color),
      );
    } else if (style == NavBarStyle.style_v1 || style == NavBarStyle.style_v2) {
      this._border = StadiumBorder(
          side: BorderSide(
        color: color,
        style: BorderStyle.solid,
      ));
      this._box = BoxDecoration(
        color: color,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(22.0)),
        //设置四周边框
        border: Border.all(width: 1, color: color),
      );
    }
  } // 私有构造方法
}
// extension SuperNavBarExtension on OutlinedBorder {
//    OutlinedBorder? borderWithStyle(NavBarStyle? style) {
//     if (style == NavBarStyle.style1 || style == NavBarStyle.style2) {
//       return StadiumBorder(
//           side: BorderSide(
//         color: Colors.red,
//         style: BorderStyle.solid,
//       ));
//     } else if (style == NavBarStyle.style3 || style == NavBarStyle.style4) {
//       return RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(0),
//         side: BorderSide(
//           width: 2,
//           color: Colors.red,
//           style: BorderStyle.solid,
//         ),
//       );
//     }
//     return null;
//   }
// }



