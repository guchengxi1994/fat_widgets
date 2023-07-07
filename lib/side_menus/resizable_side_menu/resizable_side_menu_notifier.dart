import 'package:flutter/material.dart';

class ResizableSidemenuNotifier extends ChangeNotifier {
  final double minWidth;
  ResizableSidemenuNotifier({required this.minWidth});

  late double currentSidemenuWidth = minWidth;

  changeSidemenuWidth(DragUpdateDetails details) {
    if (currentSidemenuWidth + details.delta.dx > minWidth) {
      currentSidemenuWidth = currentSidemenuWidth + details.delta.dx;
      notifyListeners();
    }
  }
}
