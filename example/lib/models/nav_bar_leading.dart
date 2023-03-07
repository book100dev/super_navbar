part of super_nav_bar_lib;

class NavBarLeading extends StatelessWidget {
  final NavBarDecoration? navBarDecoration;
  const NavBarLeading({Key? key, this.navBarDecoration}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 40,
        maxWidth: 100
      ),
      decoration: this.navBarDecoration?.logoUrl?.isEmpty == true ? BoxDecoration() : BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(this.navBarDecoration!.logoUrl!)..evict(),
              //图片填充方式
              fit: BoxFit.fitWidth,
              //图片位置
              alignment: Alignment.center,
              //图片平铺方式
              repeat: ImageRepeat.repeatY,
            ),
          ),
    );
  }
}
