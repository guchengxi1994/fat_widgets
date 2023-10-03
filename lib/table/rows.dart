import 'package:flutter/material.dart';

import 'columns.dart';

class CustomTableRow {
  final List<Widget> dataCells;
  final BoxDecoration? decoration;

  CustomTableRow({required this.dataCells, this.decoration});
}

class DataTableRow extends StatelessWidget {
  DataTableRow(
      {Key? key,
      required this.dataCells,
      this.decoration,
      required this.status,
      this.circle = false})
      : super(key: key);
  final List<Widget> dataCells;
  final BoxDecoration? decoration;
  final ValueNotifier<SelectStatus> status;
  final bool circle;

  final ValueNotifier<bool> selected = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selected,
        builder: (c, b, w) {
          final showIcon = status.value != SelectStatus.none;
          final Icon icon;
          if (status.value == SelectStatus.all) {
            selected.value = true;
          }

          if (!circle) {
            if (selected.value == true) {
              icon = const Icon(Icons.check_box);
            } else {
              icon = const Icon(Icons.check_box_outline_blank);
            }
          } else {
            if (selected.value) {
              icon = const Icon(Icons.check_circle);
            } else {
              icon = const Icon(Icons.circle_outlined);
            }
          }

          return Container(
            decoration: decoration,
            child: Row(
              children: [
                if (showIcon)
                  InkWell(
                    onTap: () {
                      selected.value = !selected.value;
                    },
                    child: SizedBox(
                      width: 40,
                      child: icon,
                    ),
                  ),
                ...dataCells
              ],
            ),
          );
        });
  }
}
