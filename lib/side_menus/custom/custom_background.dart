import 'package:flutter/material.dart';

/// 参考 https://www.jianshu.com/p/ffea2c98b4d4
class CustomBackground extends CustomClipper<Path> {
  CustomBackground({required this.offsetOnVertical, this.indicatorSize = 30});

  final double offsetOnVertical;
  final double indicatorSize;

  @override
  getClip(Size size) {
    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, offsetOnVertical);
    final (p2x, p2y) = (size.width, offsetOnVertical + indicatorSize);
    final (p1x, p1y) = (
      size.width - indicatorSize,
      (offsetOnVertical + indicatorSize + offsetOnVertical) / 2
    );
    path.quadraticBezierTo(p1x, p1y, p2x, p2y);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomBackground oldClipper) {
    return oldClipper != this;
  }
}
