import 'package:flutter/material.dart';

import 'expand_collapse_notifier.dart';
import 'functions.dart';

class _MyClipper extends CustomClipper<Rect> {
  _MyClipper({required Animation<double> reclip})
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

class MultiLevelSideMenu extends StatefulWidget {
  const MultiLevelSideMenu(
      {super.key,
      required this.destinations,
      required this.onDestinationSelected,
      this.initialIndex = 0,
      required this.body,
      this.labelType = NavigationRailLabelType.none,
      this.leading,
      this.maxWidth = 200,
      this.minWidth = 75,
      this.decoration,
      this.onExpansionChanged});
  final List<NavigationRailDestination> destinations;
  final OnDestinationSelected onDestinationSelected;
  final int initialIndex;
  final Widget body;
  final NavigationRailLabelType labelType;
  final Widget? leading;
  final double minWidth;
  final double maxWidth;
  final BoxDecoration? decoration;
  final OnExpansionChanged? onExpansionChanged;

  @override
  State<MultiLevelSideMenu> createState() => MultiLevelSideMenuState();
}

const int duration = 200;

class MultiLevelSideMenuState extends State<MultiLevelSideMenu>
    with TickerProviderStateMixin {
  late int selectedIndex = widget.initialIndex;

  late final notifier = ExpandCollapseNotifier(
      minWidth: widget.minWidth, maxWidth: widget.maxWidth);

  late AnimationController _controller;
  late Animation<double> _animation;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    notifier.addListener(() => mounted ? setState(() {}) : null);
    _controller = AnimationController(
      duration: const Duration(milliseconds: duration),
      vsync: this,
    );
    _animation = _controller
        .drive(Tween<double>(begin: widget.minWidth, end: widget.maxWidth));
  }

  _toggleSidemenu() {
    if (!_controller.isAnimating && !_controller.isCompleted) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    notifier.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  changeIndex(int i) {
    if (selectedIndex != i) {
      setState(() {
        selectedIndex = i;
      });
    }
  }

  late BoxDecoration decoration = widget.decoration ??
      const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
        color: Colors.blueAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            spreadRadius: 0.0,
            offset: Offset(5, 0), // shadow direction: bottom right
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    if (widget.destinations.isEmpty) {
      return Row(
        children: [
          Container(
            decoration: decoration,
          ),
          const Expanded(child: SizedBox()),
        ],
      );
    }

    if (widget.destinations.length == 1) {
      return Stack(
        children: [
          Row(
            children: [
              ClipRect(
                  clipper: _MyClipper(
                    reclip: _animation,
                  ),
                  child: Container(
                    decoration: decoration,
                    width: isExpanded ? widget.maxWidth : widget.minWidth,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Center(
                            child: isExpanded
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 2,
                                              bottom: 2),
                                          child: widget.destinations.first.icon,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        widget.destinations.first.label
                                      ],
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, top: 2, bottom: 2),
                                    child: widget.destinations.first.icon,
                                  ),
                          ),
                        )
                      ],
                    ),
                  )),
              Expanded(child: widget.body),
            ],
          ),
          Positioned(
              left: notifier.currentWidth - 10,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeLeft,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final b = notifier.changeSidemenuWidth(details);
                    if (isExpanded != b) {
                      setState(() {
                        isExpanded = b;
                      });
                      _toggleSidemenu();
                    }

                    if (widget.onExpansionChanged != null) {
                      widget.onExpansionChanged!(b);
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 20,
                    height: MediaQuery.of(context).size.height,
                    // child: const SizedBox.expand(),
                  ),
                ),
              ))
        ],
      );
    }

    return Stack(
      children: [
        Row(
          children: [
            Container(
              decoration: decoration,
              child: NavigationRail(
                // selectedIconTheme: const IconThemeData(color: Colors.white),
                unselectedIconTheme: const IconThemeData(color: Colors.black),
                selectedLabelTextStyle: const TextStyle(color: Colors.white),
                extended: notifier.isExpanded,
                minWidth: widget.minWidth,
                minExtendedWidth: widget.maxWidth,
                destinations: widget.destinations,
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  changeIndex(value);
                  widget.onDestinationSelected(value);
                },
                labelType: NavigationRailLabelType.none,
                backgroundColor: Colors.transparent,
              ),
            ),
            Expanded(child: widget.body),
          ],
        ),
        Positioned(
            left: notifier.currentWidth - 10,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeLeft,
              child: GestureDetector(
                onPanUpdate: (details) {
                  final b = notifier.changeSidemenuWidth(details);
                  if (widget.onExpansionChanged != null) {
                    widget.onExpansionChanged!(b);
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  width: 20,
                  height: MediaQuery.of(context).size.height,
                  // child: const SizedBox.expand(),
                ),
              ),
            ))
      ],
    );
  }
}
