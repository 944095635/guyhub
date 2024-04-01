import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/style/theme.dart';
import 'package:guyhub/util/image_helper.dart';
import 'package:image_pixels/image_pixels.dart';

/// 单个扩展子项
class ExtensionItem extends StatelessWidget {
  const ExtensionItem({
    super.key,
    required this.onTap,
    required this.extension,
  });

  final Function() onTap;

  final Extension extension;

  @override
  Widget build(BuildContext context) {
    //debugPrint("绘制:${extension.package}");
    MyTheme theme = Theme.of(context).extension<MyTheme>()!;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: theme.cardColor,
          border: Border.all(color: theme.borderColor),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor,
              blurRadius: 25,
              blurStyle: BlurStyle.outer,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (extension.icon != null) ...{
                ImagePixels.container(
                  imageProvider: CachedNetworkImageProvider(extension.icon!),
                  colorAlignment: Alignment.center,
                  child: Container(
                    color: theme.aeroColor,
                  ),
                ),
                //ImageFiltered(
                //  imageFilter: ImageFilter.blur(
                //    sigmaX: 50,
                //    sigmaY: 50,
                //  ),
                //  child: Transform.scale(
                //    scale: 2,
                //    child: CachedNetworkImage(
                //      imageUrl: extension.icon!,
                //      repeat: ImageRepeat.repeat,
                //      memCacheWidth: 80,
                //    ),
                //  ),
                //),
              },
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: buildLogo(extension.icon),
                      ),
                    ),
                    Text(
                      extension.name,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: theme.bodyColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (extension.isNsfw) ...{
                //显示18禁图标
                Positioned(
                  top: 6,
                  right: 6,
                  child: build18Logo(),
                )
              }
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogo(String? image) {
    return image != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(5.r),
            child: CachedNetworkImage(
              imageUrl: image,
              memCacheWidth: 80,
              width: 40.w,
              height: 40.w,
            ),
          )
        : Container(
            alignment: Alignment.center,
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: ImageHelper.getSvg(
              "apps",
              color: Colors.deepPurple,
              size: 22.sp,
            ),
          );
  }

  /// 18禁 图标
  Widget build18Logo() {
    return buildCard(
      color: Colors.pinkAccent,
      child: const Text(
        "18+",
        style: TextStyle(
          color: Colors.white,
          fontSize: 8,
        ),
      ),
      padding: const EdgeInsets.all(1),
    );
  }

  Widget buildCard({
    required Color color,
    required Widget child,
    EdgeInsets? padding,
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(3),
      ),
      child: child,
    );
  }
}
