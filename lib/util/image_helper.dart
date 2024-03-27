import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageHelper {
  static SvgPicture getSvg(String key, {Color? color, double? size}) {
    //"assets/svg/export.svg"
    String keyStr = "assets/svg/$key.svg";
    if (color == null) {
      return SvgPicture.asset(
        keyStr,
        width: size,
        height: size,
      );
    }
    return SvgPicture.asset(
      keyStr,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
