import 'package:fat_widgets/side_menus/custom/custom_background.dart';
import 'package:fat_widgets/side_menus/side_menu_items/side_menu_items.dart';
import 'package:flutter/material.dart';

class SingleLevelSidemenu<T extends BaseSidemenuData> extends StatefulWidget {
  SingleLevelSidemenu(
      {Key? key,
      this.decoration,
      required this.width,
      required this.height,
      required this.items,
      this.marginTop = 0,
      this.header,
      this.indicatorSize = 30})
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

  @override
  State<SingleLevelSidemenu> createState() => _SingleLevelSidemenuState();
}

class _SingleLevelSidemenuState extends State<SingleLevelSidemenu> {
  late final decoration = widget.decoration ??
      BoxDecoration(
          color: Colors.lightBlue.withAlpha(75),
          borderRadius: BorderRadius.circular(15));
  ValueNotifier<int> valueNotifier = ValueNotifier(0);

  late ConstrainedBox header = widget.header ??
      ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 100, minHeight: 100),
      );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (c, i, w) {
        final initial = widget.marginTop +
            header.constraints.maxHeight +
            widget.items.first.height / 2 - /* indicatorSize */
            widget.indicatorSize / 2;

        return ClipPath(
          clipper: CustomBackground(
            indicatorSize: widget.indicatorSize,
            offsetOnVertical:
                (widget.items.first.height * valueNotifier.value + initial),
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
