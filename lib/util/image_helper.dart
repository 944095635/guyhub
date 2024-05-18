import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageHelper {
  static SvgPicture getSvg(
    String key, {
    Color? color,
    double? size,
    BoxFit fit = BoxFit.contain,
  }) {
    //"assets/svg/export.svg"
    String keyStr = "assets/svg/$key.svg";
    if (color == null) {
      return SvgPicture.asset(
        keyStr,
        fit: fit,
        width: size,
        height: size,
      );
    }
    return SvgPicture.asset(
      keyStr,
      fit: fit,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
