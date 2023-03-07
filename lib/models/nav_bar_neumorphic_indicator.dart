part of super_nav_bar_lib;

class NavBarNeumorphicIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final double indicatorRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry insets;
  final TabBarIndicatorSize tabBarIndicatorSize;
  final bool showBeautyNevus;

  const NavBarNeumorphicIndicator({
    this.indicatorHeight: 20.0,
    this.indicatorColor: Colors.greenAccent,
    this.indicatorRadius: 100.0,
    this.tabBarIndicatorSize = TabBarIndicatorSize.label,
    this.padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
    this.insets: const EdgeInsets.symmetric(horizontal: 5.0),
    this.showBeautyNevus: false,
  });

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is NavBarNeumorphicIndicator) {
      return NavBarNeumorphicIndicator(
        padding: EdgeInsetsGeometry.lerp(a.padding, padding, t)!,
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is NavBarNeumorphicIndicator) {
      return new NavBarNeumorphicIndicator(
        padding: EdgeInsetsGeometry.lerp(padding, b.padding, t)!,
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _BubblePainter createBoxPainter([VoidCallback? onChanged]) {
    return new _BubblePainter(this, onChanged);
  }
}

class _BubblePainter extends BoxPainter {
  _BubblePainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  final NavBarNeumorphicIndicator decoration;

  double get indicatorHeight => decoration.indicatorHeight;
  Color get indicatorColor => decoration.indicatorColor;
  double get indicatorRadius => decoration.indicatorRadius;
  bool get showBeautyNevusRect => decoration.showBeautyNevus;
  EdgeInsetsGeometry get padding => decoration.padding;
  EdgeInsetsGeometry get insets => decoration.insets;
  TabBarIndicatorSize get tabBarIndicatorSize => decoration.tabBarIndicatorSize;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    Rect indicator = padding.resolve(textDirection).inflateRect(rect);

    if (tabBarIndicatorSize == TabBarIndicatorSize.tab) {
      indicator = insets.resolve(textDirection).deflateRect(rect);
    }

    return new Rect.fromLTWH(
      indicator.left,
      indicator.top,
      indicator.width,
      indicator.height,
    );
  }

  Rect _beautyNevusRectFor(Rect rect, TextDirection textDirection) {
    Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    return new Rect.fromLTWH(
      indicator.left,
      indicator.top,
      6,
      6,
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = Offset(
            offset.dx, (configuration.size!.height / 2) - indicatorHeight / 2) &
        Size(configuration.size!.width, indicatorHeight);
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator = _indicatorRectFor(rect, textDirection);
    final Paint paint = Paint();
    paint.color = indicatorColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(indicator, Radius.circular(indicatorRadius)),
        paint);

// 是否显示美人痣
    if (showBeautyNevusRect) {
      final Rect rect1 = Offset(offset.dx,
              (configuration.size!.height / 2) - indicatorHeight / 2 + 6) &
          Size(6, 6);
      final TextDirection textDirection1 = TextDirection.rtl;
      final Rect beautyNevusRect = _beautyNevusRectFor(rect1, textDirection1);
      final Paint beautyNevusPaint = Paint();
      beautyNevusPaint.color = Colors.white;
      beautyNevusPaint.style = PaintingStyle.fill;
      canvas.drawRRect(
          RRect.fromRectAndRadius(beautyNevusRect, Radius.circular(3)),
          beautyNevusPaint);
    }
  }
}
