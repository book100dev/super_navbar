part of super_nav_bar_lib;

class NavBarController {
  String? globalBookBgImage;

  ValueChanged<ShopCartBadgeViewModel>? shopCartBadgeChanged;

  late List<BadgeViewModel> badgeViewModels;

  ShopCartBadgeViewModel shopCartBadgeViewModel = ShopCartBadgeViewModel();

  void updateBadgeOnCurrentTitle(int count, int index) {
    BadgeViewModel model = getViewModelWithIndex(index);
    model.count = count;
    model.updateTitle();
  }

  BadgeViewModel getViewModelWithIndex(int index) {
    return badgeViewModels[index];
  }

  void updateShopCartBadgeView(int badgeCount, String price) {
    if (shopCartBadgeChanged != null) {
      ShopCartBadgeViewModel model = ShopCartBadgeViewModel();
      model.count = badgeCount;
      model.price = price;
      shopCartBadgeChanged!(model);
    }
  }
}
