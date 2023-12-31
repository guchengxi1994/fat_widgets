import 'package:fat_widgets/table/table_status.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

typedef OnSingleRowSelectedStatusChanged = void Function(int index);

class CustomTableRow {
  final List<Widget> dataCells;
  final BoxDecoration? decoration;
  final double rowRadius;

  CustomTableRow({
    required this.dataCells,
    this.decoration,
    this.rowRadius = 5,
  });
}

// ignore: must_be_immutable
class DataTableRow extends StatelessWidget {
  DataTableRow({
    Key? key,
    required this.dataCells,
    this.decoration,
    required this.status,
    this.circle = false,
    required this.index,
    required this.columnWidth,
    this.rowHeight = 50,
    this.onSingleRowSelectedChanged,
    this.rowRadius = 5,
  }) : super(key: key);
  final List<Widget> dataCells;
  final BoxDecoration? decoration;
  ValueNotifier<TableStatus> status;
  final bool circle;
  final int index;
  final List<double?> columnWidth;
  final double rowHeight;
  final OnSingleRowSelectedStatusChanged? onSingleRowSelectedChanged;
  final double rowRadius;

  @override
  Widget build(BuildContext context) {
    final showIcon = status.value.selectStatus != SelectStatus.none;
    bool selected = status.value.selectedIndexes.contains(index);
    final Icon icon;

    if (!circle) {
      if (selected == true) {
        icon = const Icon(Icons.check_box);
      } else {
        icon = const Icon(Icons.check_box_outline_blank);
      }
    } else {
      if (selected) {
        icon = const Icon(Icons.check_circle);
      } else {
        icon = const Icon(Icons.circle_outlined);
      }
    }

    return InkWell(
      borderRadius: BorderRadius.circular(rowRadius),
      onTap: () {
        if (showIcon) {
          List<int> l = List.from(status.value.selectedIndexes);
          if (l.contains(index)) {
            l.remove(index);
          } else {
            l.add(index);
          }
          final SelectStatus selectStatus;
          if (l.length == status.value.rowLength) {
            selectStatus = SelectStatus.all;
          } else if (l.isEmpty) {
            selectStatus = SelectStatus.zero;
          } else {
            selectStatus = SelectStatus.some;
          }

          status.value = TableStatus(
              selectStatus: selectStatus,
              rowLength: status.value.rowLength,
              selectedIndexes: l);
        }
      },
      child: Container(
        height: rowHeight,
        decoration: decoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon)
              InkWell(
                onTap: () {
                  // selected.value = !selected.value;
                  List<int> l = List.from(status.value.selectedIndexes);
                  if (l.contains(index)) {
                    l.remove(index);
                  } else {
                    l.add(index);
                  }
                  final SelectStatus selectStatus;
                  if (l.length == status.value.rowLength) {
                    selectStatus = SelectStatus.all;
                  } else if (l.isEmpty) {
                    selectStatus = SelectStatus.zero;
                  } else {
                    selectStatus = SelectStatus.some;
                  }

                  status.value = TableStatus(
                      selectStatus: selectStatus,
                      rowLength: status.value.rowLength,
                      selectedIndexes: l);

                  if (onSingleRowSelectedChanged != null) {
                    onSingleRowSelectedChanged!(index);
                  }
                },
                child: SizedBox(
                  width: 40,
                  height: rowHeight,
                  child: icon,
                ),
              ),
            ...wrapper()
          ],
        ),
      ),
    );
  }

  List<Widget> wrapper() {
    return dataCells
        .mapIndexed((i, e) => columnWidth[i] == null
            ? Expanded(
                child: SizedBox(
                height: rowHeight,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: e,
                ),
              ))
            : SizedBox(
                height: rowHeight,
                width: columnWidth[i],
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: e,
                ),
              ))
        .toList();
  }
}
