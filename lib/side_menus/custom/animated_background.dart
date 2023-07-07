import 'package:flutter/material.dart';

class AnimatedCustomBackground extends CustomClipper<Path> {
  AnimatedCustomBackground({this.indicatorSize = 30, required this.reclip})
      : super(reclip: reclip);

  final double indicatorSize;
  final Animation<double> reclip;

  @override
  getClip(Size size) {
    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, reclip.value);
    final (p2x, p2y) = (size.width, reclip.value + indicatorSize);
    final (p1x, p1y) = (
      size.width - indicatorSize,
      (reclip.value + indicatorSize + reclip.value) / 2
    );
    path.quadraticBezierTo(p1x, p1y, p2x, p2y);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant AnimatedCustomBackground oldClipper) {
    return oldClipper != this;
  }
}
