part of super_nav_bar_lib;

class VTabFooterView extends ViewModelBuilderWidget<ShopCartBadgeViewModel> {
  final ValueChanged<NavBarAction>? actionBlock;
  final ShopCartBadgeViewModel viewModel;
  const VTabFooterView({Key? key, required this.viewModel, this.actionBlock})
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
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              if (actionBlock != null) {
                actionBlock!(NavBarAction.logout);
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                overlayColor: MaterialStateProperty.all(Colors.black), // 高亮色
                shape: MaterialStateProperty.all(CircleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.white,
                    style: BorderStyle.solid,
                  ),
                ))),
            child: Icon(
              Icons.login_rounded,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (actionBlock != null) {
                actionBlock!(NavBarAction.search);
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                overlayColor: MaterialStateProperty.all(Colors.black), // 高亮色
                shape: MaterialStateProperty.all(CircleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.white,
                    style: BorderStyle.solid,
                  ),
                ))),
            child: Icon(
              Icons.manage_search,
            ),
          ),
          Container(
            height: 60,
            child: ElevatedButton(
                onPressed: () {
                  if (actionBlock != null) {
                    actionBlock!(NavBarAction.shopCart);
                  }
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    overlayColor:
                        MaterialStateProperty.all(Colors.black), // 高亮色
                    shape: MaterialStateProperty.all(CircleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white,
                        style: BorderStyle.solid,
                      ),
                    ))),
                child: badges.Badge(
                  badgeStyle: badges.BadgeStyle(
                    shape: badges.BadgeShape.square,
                    borderRadius: BorderRadius.circular(5),
                    padding: EdgeInsets.all(2),
                    badgeGradient: badges.BadgeGradient.linear(
                      colors: [
                        Colors.purple,
                        Colors.blue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  showBadge: viewModel.count > 0 ? true : false,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 40,
                  ),
                  badgeContent: Text(viewModel.price,
                      style: TextStyle(color: Colors.white)),
                )),
          )
        ],
      ),
    );
  }

  @override
  ShopCartBadgeViewModel viewModelBuilder(BuildContext context) => viewModel;
}
