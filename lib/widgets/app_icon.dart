import 'package:cchurch/utils/dimensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color BackgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  const AppIcon(
      {Key? key,
      required this.icon,
      this.BackgroundColor = const Color(0xFFfcf4e4),
      this.iconColor = const Color(0xFF756d54),
      this.size = 40,
      this.iconSize = 16
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: BackgroundColor),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
