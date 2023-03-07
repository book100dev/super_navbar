part of super_nav_bar_lib;

const _SuperFoodMenuThemeDefaults _kDefaultTheme = _SuperFoodMenuThemeDefaults(
  CupertinoColors.systemBlue,
  Colors.white,
  // _CupertinoTextThemeDefaults(CupertinoColors.label, CupertinoColors.inactiveGray),
);

class SuperFoodMenuTheme extends StatelessWidget {
  const SuperFoodMenuTheme({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  final SuperFoodMenuThemeData data;

  static SuperFoodMenuThemeData of(BuildContext context) {
    final _InheritedSuperFoodMenuTheme? inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedSuperFoodMenuTheme>();
    return (inheritedTheme?.theme.data ?? const SuperFoodMenuThemeData())
        .resolveFrom(context);
  }

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _InheritedSuperFoodMenuTheme(
      theme: this,
      child: IconTheme(
        data: CupertinoIconThemeData(color: data.primaryColor),
        child: child,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class _InheritedSuperFoodMenuTheme extends InheritedWidget {
  const _InheritedSuperFoodMenuTheme({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  final SuperFoodMenuTheme theme;

  @override
  bool updateShouldNotify(_InheritedSuperFoodMenuTheme old) =>
      theme.data != old.theme.data;
}

@immutable
class SuperFoodMenuThemeData extends NoDefaultSuperFoodMenuThemeData
    with Diagnosticable {
  const SuperFoodMenuThemeData({
    NavBarStyle? style,
    Color? primaryColor,
    Color? navBarButonTextColor,
  }) : this.raw(
          style,
          primaryColor,
          navBarButonTextColor
        );

  @protected
  const SuperFoodMenuThemeData.raw(
    NavBarStyle? style,
    Color? primaryColor,
    Color? navBarButonTextColor,
  ) : this._rawWithDefaults(
          primaryColor,
          navBarButonTextColor,
          _kDefaultTheme,
        );

  const SuperFoodMenuThemeData._rawWithDefaults(
    Color? primaryColor,
    Color? navBarButonTextColor,
    this._defaults,
  ) : super(
          primaryColor: primaryColor,
          navBarButonTextColor: navBarButonTextColor
        );

  final _SuperFoodMenuThemeDefaults _defaults;

  @override
  Color get primaryColor => super.primaryColor ?? _defaults.primaryColor;

  @override
  Color get navBarButonTextColor => super.navBarButonTextColor ?? _defaults.navBarButonTextColor;
  // @override
  // CupertinoTextThemeData get textTheme {
  //   return super.textTheme ?? _defaults.textThemeDefaults.createDefaults(primaryColor: primaryColor);
  // }

  @override
  NoDefaultSuperFoodMenuThemeData noDefault() {
    return NoDefaultSuperFoodMenuThemeData(
      primaryColor: super.primaryColor,
    );
  }

  @override
  SuperFoodMenuThemeData resolveFrom(BuildContext context) {
    Color? convertColor(Color? color) =>
        CupertinoDynamicColor.maybeResolve(color, context);
    return SuperFoodMenuThemeData._rawWithDefaults(
      convertColor(super.primaryColor),
      convertColor(super.navBarButonTextColor),
      _defaults.resolveFrom(context, super.textTheme == null),
    );
  }

  // @override
  // SuperFoodMenuThemeData copyWith({
  //   Color? primaryColor,
  //   Color? navBarButonTextColor,
  // }) {
  //   return SuperFoodMenuThemeData._rawWithDefaults(
  //     primaryColor ?? super.primaryColor,
  //     navBarButonTextColor ?? super.navBarButonTextColor,
  //     _defaults,
  //   );
  // }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    const SuperFoodMenuThemeData defaultData = SuperFoodMenuThemeData();
    properties.add(createCupertinoColorProperty('primaryColor', primaryColor,
        defaultValue: defaultData.primaryColor));
    // textTheme.debugFillProperties(properties);
  }
}

class NoDefaultSuperFoodMenuThemeData {
  const NoDefaultSuperFoodMenuThemeData({
    this.style,
    this.primaryColor,
    this.navBarButonTextColor,
    this.textTheme,
  });

  final NavBarStyle? style;

  final Color? primaryColor;

  final Color? navBarButonTextColor;

  final CupertinoTextThemeData? textTheme;

  NoDefaultSuperFoodMenuThemeData noDefault() => this;

  @protected
  NoDefaultSuperFoodMenuThemeData resolveFrom(BuildContext context) {
    Color? convertColor(Color? color) =>
        CupertinoDynamicColor.maybeResolve(color, context);
    return NoDefaultSuperFoodMenuThemeData(
      primaryColor: convertColor(primaryColor),
      navBarButonTextColor: convertColor(navBarButonTextColor),
      textTheme: textTheme?.resolveFrom(context),
    );
  }

  NoDefaultSuperFoodMenuThemeData copyWith({
    Color? primaryColor,
    Color? navBarButonTextColor,
    CupertinoTextThemeData? textTheme,
  }) {
    return NoDefaultSuperFoodMenuThemeData(
      primaryColor: primaryColor ?? this.primaryColor,
      navBarButonTextColor: navBarButonTextColor ?? this.navBarButonTextColor,
      textTheme: textTheme ?? this.textTheme,
    );
  }
}

@immutable
class _SuperFoodMenuThemeDefaults {
  const _SuperFoodMenuThemeDefaults(
    this.primaryColor,
    this.navBarButonTextColor
  );
  final Color primaryColor;
  final Color navBarButonTextColor;

  _SuperFoodMenuThemeDefaults resolveFrom(
      BuildContext context, bool resolveTextTheme) {
    Color convertColor(Color color) =>
        CupertinoDynamicColor.resolve(color, context);
    return _SuperFoodMenuThemeDefaults(
      convertColor(primaryColor),
      convertColor(navBarButonTextColor)
      // resolveTextTheme ? textThemeDefaults.resolveFrom(context) : textThemeDefaults,
    );
  }
}

// @immutable
// class _CupertinoTextThemeDefaults {
//   const _CupertinoTextThemeDefaults(
//     this.labelColor,
//     this.inactiveGray,
//   );

//   final Color labelColor;
//   final Color inactiveGray;

//   _CupertinoTextThemeDefaults resolveFrom(BuildContext context) {
//     return _CupertinoTextThemeDefaults(
//       CupertinoDynamicColor.resolve(labelColor, context),
//       CupertinoDynamicColor.resolve(inactiveGray, context),
//     );
//   }

//   CupertinoTextThemeData createDefaults({ required Color primaryColor }) {;
//     return _DefaultCupertinoTextThemeData(
//       primaryColor: primaryColor,
//       labelColor: labelColor,
//       inactiveGray: inactiveGray,
//     );
//   }
// }

// class _DefaultCupertinoTextThemeData extends CupertinoTextThemeData {
//   const _DefaultCupertinoTextThemeData({
//     required this.labelColor,
//     required this.inactiveGray,
//     required Color primaryColor,
//   }) : super(primaryColor: primaryColor);

//   final Color labelColor;
//   final Color inactiveGray;

//   @override
//   TextStyle get textStyle => super.textStyle.copyWith(color: labelColor);

//   @override
//   TextStyle get tabLabelTextStyle => super.tabLabelTextStyle.copyWith(color: inactiveGray);

//   @override
//   TextStyle get navTitleTextStyle => super.navTitleTextStyle.copyWith(color: labelColor);

//   @override
//   TextStyle get navLargeTitleTextStyle => super.navLargeTitleTextStyle.copyWith(color: labelColor);

//   @override
//   TextStyle get pickerTextStyle => super.pickerTextStyle.copyWith(color: labelColor);

//   @override
//   TextStyle get dateTimePickerTextStyle => super.dateTimePickerTextStyle.copyWith(color: labelColor);
// }
