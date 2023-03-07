part of super_nav_bar_lib;

class ShopCartBadgeViewModel extends BaseViewModel {
  int count = 0;
  String price = '';
  void initialise() {
    price = '';
    notifyListeners();
  }
  void updateTitle() {
    notifyListeners();
  }
}

