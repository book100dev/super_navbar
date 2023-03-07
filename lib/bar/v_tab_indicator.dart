part of super_nav_bar_lib;

class VUnderlineTabIndicator extends Decoration {
  const VUnderlineTabIndicator({
    this.indicatorHeight: 20.0,
    this.indicatorColor: Colors.greenAccent,
    this.indicatorRadius: 100.0,
    this.tabBarIndicatorSize = TabBarIndicatorSize.label,
    this.padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
    this.insets: const EdgeInsets.symmetric(horizontal: 5.0),
    this.showBeautyNevus: false,
  });

  final double indicatorHeight;
  final Color indicatorColor;
  final double indicatorRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry insets;
  final TabBarIndicatorSize tabBarIndicatorSize;
  final bool showBeautyNevus;

  // final BorderSide borderSide;

  // final EdgeInsetsGeometry insets;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is VUnderlineTabIndicator) {
      return VUnderlineTabIndicator(
        padding: EdgeInsetsGeometry.lerp(a.padding, padding, t)!,
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
        // borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        // insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
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
  _UnderlinePainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(this, onChanged);
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.decoration, VoidCallback? onChanged)
      : assert(decoration != null),
        super(onChanged);

  final VUnderlineTabIndicator decoration;

  double get indicatorHeight => decoration.indicatorHeight;
  Color get indicatorColor => decoration.indicatorColor;
  double get indicatorRadius => decoration.indicatorRadius;
  bool get showBeautyNevusRect => decoration.showBeautyNevus;
  EdgeInsetsGeometry get padding => decoration.padding;
  EdgeInsetsGeometry get insets => decoration.insets;
  TabBarIndicatorSize get tabBarIndicatorSize => decoration.tabBarIndicatorSize;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    return Rect.fromLTWH(
        0,
        indicator.left,
        indicatorHeight,
        indicator.width);
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator = _indicatorRectFor(rect, textDirection);
    final Paint paint = Paint();
    paint.color = indicatorColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(indicator, Radius.circular(1)), paint);
    if (showBeautyNevusRect) {
      final Rect rect1 = offset & Size(6, 6);

      final TextDirection textDirection1 = configuration.textDirection!;
      final Rect beautyNevusRect = _beautyNevusRectFor(rect1, textDirection1);
      final Paint beautyNevusPaint = Paint();
      beautyNevusPaint.color = Colors.white;
      beautyNevusPaint.style = PaintingStyle.fill;

      canvas.drawRRect(
          RRect.fromRectAndRadius(beautyNevusRect, Radius.circular(3)),
          beautyNevusPaint);
    }
  }

  Rect _beautyNevusRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    return Rect.fromLTWH(10, indicator.left + 10, 6, 6);
  }
}
