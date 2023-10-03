import 'package:fat_widgets/table/table_status.dart';
import 'package:flutter/material.dart';

class CustomTableRow {
  final List<Widget> dataCells;
  final BoxDecoration? decoration;

  CustomTableRow({required this.dataCells, this.decoration});
}

// ignore: must_be_immutable
class DataTableRow extends StatelessWidget {
  DataTableRow(
      {Key? key,
      required this.dataCells,
      this.decoration,
      required this.status,
      this.circle = false,
      required this.index})
      : super(key: key);
  final List<Widget> dataCells;
  final BoxDecoration? decoration;
  TableStatus status;
  final bool circle;
  final int index;

  @override
  Widget build(BuildContext context) {
    final showIcon = status.selectStatus != SelectStatus.none;
    bool selected = status.selectedIndexes.contains(index);
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

    return Container(
      decoration: decoration,
      child: Row(
        children: [
          if (showIcon)
            InkWell(
              onTap: () {
                // selected.value = !selected.value;
                List<int> l = List.from(status.selectedIndexes);
                print(l);
                if (l.contains(index)) {
                  l.remove(index);
                } else {
                  l.add(index);
                }
                print(l);
                final SelectStatus selectStatus;
                if (l.length == status.rowLength) {
                  selectStatus = SelectStatus.all;
                } else if (l.isEmpty) {
                  selectStatus = SelectStatus.zero;
                } else {
                  selectStatus = SelectStatus.some;
                }

                status = TableStatus(
                    selectStatus: selectStatus,
                    rowLength: status.rowLength,
                    selectedIndexes: l);
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
  }
}
