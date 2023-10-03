import 'package:flutter/material.dart';

import 'column_item.dart';

enum SelectStatus { none, all, some, zero }

class DataTableColumn extends StatelessWidget {
  DataTableColumn(
      {Key? key,
      required this.columns,
      this.decoration,
      this.circle = false,
      required this.status})
      : assert(columns.isNotEmpty),
        super(key: key);
  final List<ColumnItem> columns;
  final BoxDecoration? decoration;
  final ValueNotifier<SelectStatus> status;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: status,
        builder: (c, b, w) {
          final showIcon = status.value != SelectStatus.none;
          final Icon icon;
          if (!circle) {
            if (status.value == SelectStatus.all) {
              icon = const Icon(Icons.check_box);
            } else if (status.value == SelectStatus.some) {
              icon = const Icon(Icons.indeterminate_check_box);
            } else {
              icon = const Icon(Icons.check_box_outline_blank);
            }
          } else {
            if (status.value == SelectStatus.all) {
              icon = const Icon(Icons.check_circle);
            } else if (status.value == SelectStatus.some) {
              icon = const Icon(Icons.remove_circle);
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
                      if (status.value == SelectStatus.all) {
                        status.value = SelectStatus.zero;
                        return;
                      }
                      if (status.value == SelectStatus.some ||
                          status.value == SelectStatus.zero) {
                        status.value = SelectStatus.all;
                        return;
                      }
                    },
                    child: SizedBox(
                      width: 40,
                      child: icon,
                    ),
                  ),
                ...columns
              ],
            ),
          );
        });
  }
}
