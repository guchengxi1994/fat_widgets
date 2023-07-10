import 'package:flutter/material.dart';

/// 参考 https://juejin.cn/post/7169353904289742856
void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClipRectApp(),
    ));

class ClipRectApp extends StatefulWidget {
  const ClipRectApp({super.key});

  @override
  State<ClipRectApp> createState() => _ClipRectAppState();
}

class _ClipRectAppState extends State<ClipRectApp>
    with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late Animation<double> _animation;
  @override
  void initState() {
    _sizeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = _sizeController.drive(Tween<double>(begin: 50, end: 100.0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                if (!_sizeController.isAnimating &&
                    !_sizeController.isCompleted) {
                  _sizeController.forward();
                } else {
                  _sizeController.reverse();
                }
              },
              child: const Text("click")),
          ClipRect(
              clipper: MyClipper(
                reclip: _animation,
              ),
              child: Container(
                width: 100,
                height: MediaQuery.of(context).size.height,
                color: Colors.blue[300],
              ))
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  MyClipper({required Animation<double> reclip})
      : _reclip = reclip,
        super(reclip: reclip);
  final Animation<double> _reclip;
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, _reclip.value, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
