import 'package:fat_widgets/side_menus/custom/animated_background.dart';
import 'package:fat_widgets/side_menus/side_menu_items/side_menu_items.dart';
import 'package:flutter/material.dart';

class AnimatedSingleLevelSidemenu<T extends BaseSidemenuData>
    extends StatefulWidget {
  AnimatedSingleLevelSidemenu(
      {Key? key,
      this.decoration,
      required this.width,
      required this.height,
      required this.items,
      this.marginTop = 0,
      this.header,
      this.indicatorSize = 30,
      this.durationInMilliseconds = 500})
      : super(key: key) {
    assert(items.isNotEmpty, "items must not be empty");
    if (header != null) {
      assert(header!.constraints.maxHeight == header!.constraints.minHeight,
          "maxHeight must equal to minHeight");
    }
  }
  final BoxDecoration? decoration;
  final double width;
  final double height;
  final List<T> items;
  final double marginTop;
  final ConstrainedBox? header;
  final double indicatorSize;
  final int durationInMilliseconds;

  @override
  State<AnimatedSingleLevelSidemenu> createState() =>
      _AnimatedSingleLevelSidemenuState();
}

class _AnimatedSingleLevelSidemenuState
    extends State<AnimatedSingleLevelSidemenu> with TickerProviderStateMixin {
  late final decoration = widget.decoration ??
      BoxDecoration(
          color: Colors.lightBlue.withAlpha(75),
          borderRadius: BorderRadius.circular(15));
  ValueNotifier<int> valueNotifier = ValueNotifier(0);

  late ConstrainedBox header = widget.header ??
      ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 100, minHeight: 100),
      );

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.durationInMilliseconds))
      ..reset();
    _animation = Tween<double>(begin: 0.0, end: initial).animate(_controller);

    _controller.forward();

    valueNotifier.addListener(() {
      end = widget.items.first.height * valueNotifier.value + initial;
      _animation = Tween<double>(begin: start, end: end).animate(_controller);
      _controller.reset();
      _controller.forward();

      setState(() {
        start = end;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late final double initial = widget.marginTop +
      header.constraints.maxHeight +
      widget.items.first.height / 2 - /* indicatorSize */
      widget.indicatorSize / 2;

  late double end = initial;
  late double start = initial;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (c, i, w) {
        return ClipPath(
          clipper: AnimatedCustomBackground(
            indicatorSize: widget.indicatorSize,
            reclip: _animation,
          ),
          child: Container(
              decoration: decoration,
              width: widget.width,
              height: widget.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header,
                  ...widget.items.map((e) => e.toWidget(valueNotifier)).toList()
                ],
              )),
        );
      },
    );
  }
}
