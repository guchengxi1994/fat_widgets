import 'package:flutter/material.dart';

import 'column_item.dart';
import 'table_status.dart';

// ignore: must_be_immutable
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
  ValueNotifier<TableStatus> status;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: status,
        builder: (c, b, w) {
          final showIcon = status.value.selectStatus != SelectStatus.none;
          final Icon icon;
          if (!circle) {
            if (status.value.selectStatus == SelectStatus.all) {
              icon = const Icon(Icons.check_box);
            } else if (status.value.selectStatus == SelectStatus.some) {
              icon = const Icon(Icons.indeterminate_check_box);
            } else {
              icon = const Icon(Icons.check_box_outline_blank);
            }
          } else {
            if (status.value.selectStatus == SelectStatus.all) {
              icon = const Icon(Icons.check_circle);
            } else if (status.value.selectStatus == SelectStatus.some) {
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
                      if (status.value.selectStatus == SelectStatus.all) {
                        // status.value.selectStatus = SelectStatus.zero;
                        status.value = TableStatus(
                            selectStatus: SelectStatus.zero,
                            selectedIndexes: [],
                            rowLength: status.value.rowLength);
                        return;
                      }
                      if (status.value.selectStatus == SelectStatus.some ||
                          status.value.selectStatus == SelectStatus.zero) {
                        // status.value.selectStatus = SelectStatus.all;
                        status.value = TableStatus(
                            selectStatus: SelectStatus.all,
                            selectedIndexes: List.generate(
                                status.value.rowLength, (index) => index),
                            rowLength: status.value.rowLength);
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
