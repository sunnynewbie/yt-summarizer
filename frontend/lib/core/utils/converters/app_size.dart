import 'package:flutter/material.dart';

enum Breakpoints {
  mobile(430),
  tablet(600),
  web(1200);

  final double width;

  const Breakpoints(this.width);
}

extension SizeUtil on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  Size get size => MediaQuery.sizeOf(this);

  Breakpoints get breakPoint {
    if (width < Breakpoints.mobile.width) {
      return Breakpoints.mobile;
    } else if (width < Breakpoints.tablet.width) {
      return Breakpoints.tablet;
    } else {
      return Breakpoints.web;
    }
  }

  bool get isMobile => breakPoint == Breakpoints.mobile;

  bool get isTablet => breakPoint == Breakpoints.tablet;

  bool get isWeb => breakPoint == Breakpoints.web;
}
