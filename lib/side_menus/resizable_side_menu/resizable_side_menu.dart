import 'package:fat_widgets/side_menus/custom/custom_background.dart';
import 'package:fat_widgets/side_menus/resizable_side_menu/resizable_side_menu_notifier.dart';
import 'package:flutter/material.dart';

import '../side_menu_items/side_menu_items.dart';

class ResizableSidemenu<T extends BaseSidemenuData> extends StatefulWidget {
  ResizableSidemenu(
      {super.key,
      this.decoration,
      required this.minWidth,
      required this.height,
      required this.items,
      this.marginTop = 0,
      this.header,
      required this.pageView}) {
    assert(items.isNotEmpty, "items must not be empty");
    if (header != null) {
      assert(header!.constraints.maxHeight == header!.constraints.minHeight,
          "maxHeight must equal to minHeight");
    }
  }

  final BoxDecoration? decoration;
  final double minWidth;
  final double height;
  final List<T> items;
  final double marginTop;
  final ConstrainedBox? header;

  final PageView pageView;

  @override
  State<ResizableSidemenu> createState() => _ResizableSidemenuState();
}

class _ResizableSidemenuState extends State<ResizableSidemenu> {
  late final decoration = widget.decoration ??
      BoxDecoration(
          color: Colors.lightBlue.withAlpha(75),
          borderRadius: BorderRadius.circular(15));

  late ConstrainedBox header = widget.header ??
      ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 100, minHeight: 100),
      );

  ValueNotifier<int> valueNotifier = ValueNotifier(0);

  late final notifier = ResizableSidemenuNotifier(minWidth: widget.minWidth);

  @override
  void initState() {
    super.initState();
    notifier.addListener(() => mounted ? setState(() {}) : null);
  }

  @override
  void dispose() {
    notifier.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (c, i, w) {
          return Stack(
            children: [
              Row(
                children: [
                  ClipPath(
                    clipper: CustomBackground(
                      indicatorSize: 0,
                      offsetOnVertical: 0,
                    ),
                    child: Container(
                        decoration: decoration,
                        width: notifier.currentSidemenuWidth,
                        height: widget.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            header,
                            ...widget.items
                                .map((e) => e.toWidget(valueNotifier))
                                .toList()
                          ],
                        )),
                  ),
                  Expanded(child: widget.pageView)
                ],
              ),
              Positioned(
                  left: notifier.currentSidemenuWidth - 10,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeft,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        notifier.changeSidemenuWidth(details);
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: widget.height,
                        width: 20,
                      ),
                    ),
                  ))
            ],
          );
        });
  }
}
