library super_nav_bar_lib;

import 'package:stacked/stacked.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:union_tabs/union_tabs.dart';
import 'dart:ui' show lerpDouble;
import 'package:flutter/gestures.dart' show DragStartBehavior;
// import 'package:flutter/widgets.dart';

part 'utils/super_navigation_utils.dart';
part 'nav-bar-styles/nav_bar_style.dart';
part 'bar/super_tab_bar.dart';
part 'models/nav_bar_decoration.dart';
part 'models/nav_bar_essentials.dart';
part 'models/nav_bar_padding.dart';
part 'bar/super_navigation_bar.dart';
part 'persistent_tab_base.dart';
part 'persistent_tab_widget.dart';
part 'models/nav_bar_neumorphic_indicator.dart';
part 'models/nav_bar_trailing.dart';
part 'models/nav_bar_controller.dart';
part 'models/nav_bar_leading.dart';
part 'bar/transparent_cupertino_navigationbar.dart';
part 'models/super_menu_theme.dart';
part 'models/app_colors.dart';
part 'bar/v_tab.dart';
part 'bar/v_tab_indicator.dart';
part 'models/badge_view_model.dart';
part 'models/shop_cart_badge_view_model.dart';
part 'models/nav_bar_action.dart';
part 'models/v_tab_fotter_view.dart';
//persistent_bottom_nav_bar
//part of super_nav_bar_lib;