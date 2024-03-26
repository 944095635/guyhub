import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';

class ImageHelper {
  static SvgPicture getSvg(String key, {Color? color}) {
    //"assets/svg/export.svg"
    String keyStr = "assets/svg/$key.svg";
    if (color == null) {
      return SvgPicture.asset(keyStr);
    }
    return SvgPicture.asset(
      keyStr,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
