import 'package:flutter/material.dart';

import 'expand_collapse_notifier.dart';

typedef OnDestinationSelected = Function(int);

class MultiLevelSideMenu extends StatefulWidget {
  MultiLevelSideMenu(
      {super.key,
      required this.destinations,
      required this.onDestinationSelected,
      this.initialIndex = 0,
      required this.body,
      this.labelType = NavigationRailLabelType.none,
      this.leading,
      this.maxWidth = 200,
      this.minWidth = 75,
      this.decoration}) {
    assert(destinations.isNotEmpty, "destinations must not be empty");
  }
  final List<NavigationRailDestination> destinations;
  final OnDestinationSelected onDestinationSelected;
  final int initialIndex;
  final Widget body;
  final NavigationRailLabelType labelType;
  final Widget? leading;
  final double minWidth;
  final double maxWidth;
  final BoxDecoration? decoration;

  @override
  State<MultiLevelSideMenu> createState() => _MultiLevelSideMenuState();
}

class _MultiLevelSideMenuState extends State<MultiLevelSideMenu> {
  late int selectedIndex = widget.initialIndex;

  late final notifier = ExpandCollapseNotifier(
      minWidth: widget.minWidth, maxWidth: widget.maxWidth);

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
                  setState(() {
                    selectedIndex = value;
                  });
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
                  notifier.changeSidemenuWidth(details);
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
