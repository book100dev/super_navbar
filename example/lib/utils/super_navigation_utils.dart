part of super_nav_bar_lib;

class SuperNavigationUtils {
    static Size sizeFromNavBarStyle(NavBarStyle? navBarStyle){
      if(navBarStyle == null) return Size.fromHeight(64.0);
      if(navBarStyle == NavBarStyle.neumorphic || navBarStyle == NavBarStyle.sunshine) {
        return Size.fromHeight(44.0);
      }
      return Size.fromHeight(84.0);
  }
}

BoxDecoration getNavBarDecoration({
  bool showElevation = true,
  NavBarDecoration? decoration = const NavBarDecoration(),

  ///不透明
  required double opacity,
  bool showBorder = true,
  bool showOpacity = true,
  Color? color = Colors.white,
}) {
  if (decoration == null) return BoxDecoration();
  if (opacity < 1.0) {
    return BoxDecoration(
      border: showBorder ? decoration.border : null,
      borderRadius: decoration.borderRadius,
      color: color!.withOpacity(opacity),
    );
  } else {
    return decoration.imagePath == null || decoration.imagePath?.length == 0
        ? BoxDecoration(
            border: showBorder ? decoration.border : null,
            borderRadius: decoration.borderRadius,
            color: color,
            gradient: decoration.gradient,
            boxShadow: decoration.boxShadow,
          )
        : BoxDecoration(
            border: showBorder ? decoration.border : null,
            borderRadius: decoration.borderRadius,
            color: color,
            image: DecorationImage(
              image: CachedNetworkImageProvider(decoration.imagePath!)..evict(),
              //图片填充方式
              fit: BoxFit.cover,
              //图片位置
              alignment: Alignment.topCenter,
              //图片平铺方式
              repeat: ImageRepeat.repeatY,
            ),
            gradient: decoration.gradient,
            boxShadow: decoration.boxShadow,
          );
  }
}

bool isColorOpaque(BuildContext context, Color? color) {
  final Color backgroundColor =
      color ?? CupertinoTheme.of(context).barBackgroundColor;
  return CupertinoDynamicColor.resolve(backgroundColor, context).alpha == 0xFF;
}

// bool opaque(List<PersistentBottomNavBarItem> items, int? selectedIndex) {
//   for (int i = 0; i < items.length; ++i) {
//     if (items[i].opacity < 1.0 && i == selectedIndex) {
//       return false;
//     }
//   }
//   return true;
// }

// double getTranslucencyAmount(
//     List<PersistentBottomNavBarItem> items, int? selectedIndex) {
//   for (int i = 0; i < items.length; ++i) {
//     if (items[i].opacity < 1.0 && i == selectedIndex) {
//       return items[i].opacity;
//     }
//   }
//   return 1.0;
// }

// Color getBackgroundColor(BuildContext context,
//     List<PersistentBottomNavBarItem>? items, Color? color, int? selectedIndex) {
//   if (color == null) {
//     return Colors.white;
//   } else if (!opaque(items!, selectedIndex) && isColorOpaque(context, color)) {
//     return color.withOpacity(getTranslucencyAmount(items, selectedIndex));
//   } else {
//     return color;
//   }
// }

extension SuperNavBarExtension on BoxDecoration {
  BoxDecoration superBoxDecoration({NavBarStyle? style, bool? selected}) {
    if (style == null) {
      return BoxDecoration();
    } else if (style == NavBarStyle.style1 || style == NavBarStyle.style3) {
      return BoxDecoration();
    } else if (style == NavBarStyle.style2 || style == NavBarStyle.style4) {
      return BoxDecoration();
    } else if (style == NavBarStyle.neumorphic) {
      return BoxDecoration();
      // return BoxDecoration(
      //     border: Border.all(color: Colors.red, width: 1), //边框
      //     color: selected! ? Colors.red : Colors.white,
      //     borderRadius: new BorderRadius.circular((18.0)));
    } else if (style == NavBarStyle.sunshine) {
      return BoxDecoration();
      return BoxDecoration(color: selected! ? Colors.red : Colors.white);
    }else if (style == NavBarStyle.style_v1) {
      return BoxDecoration();
    }else if (style == NavBarStyle.style_v2) {
      return BoxDecoration();
    }
    

    return BoxDecoration(
        border: Border.all(color: Colors.red, width: 1), //边框
        color: selected! ? Colors.red : Colors.white,
        borderRadius: new BorderRadius.circular((18.0)));
  }
}

