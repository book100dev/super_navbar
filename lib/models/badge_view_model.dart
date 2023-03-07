part of super_nav_bar_lib;

class BadgeViewModel extends ChangeNotifier {
  String title = '';
  void initialise() {
    title = '';
    notifyListeners();
  }

  int count = 0;
  void updateTitle() {
    count++;
    notifyListeners();
  }
}
