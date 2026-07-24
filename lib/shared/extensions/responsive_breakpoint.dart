import 'package:flutter/material.dart';

enum ScreenSize { phone, tablet, desktop }

extension ResponsiveBreakpoint on BuildContext {
  ScreenSize get screenSize {
    final w = MediaQuery.of(this).size.width;
    if (w >= 900) return ScreenSize.desktop;
    if (w >= 600) return ScreenSize.tablet;
    return ScreenSize.phone;
  }

  bool get isPhone => screenSize == ScreenSize.phone;
  bool get isTablet => screenSize == ScreenSize.tablet;
  bool get isDesktop => screenSize == ScreenSize.desktop;

  double get contentWidth {
    if (isDesktop) return 900;
    return MediaQuery.of(this).size.width;
  }

  EdgeInsets get pagePadding => EdgeInsets.all(isPhone ? 12 : 16);

  bool get useNavigationRail => isDesktop;

  double get navRailWidth => 72;
}
