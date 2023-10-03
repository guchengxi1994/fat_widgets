import 'package:fat_widgets/table/rows.dart';
import 'package:flutter/material.dart';

import 'column_item.dart';
import 'columns.dart';
import 'table_status.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

// ignore: must_be_immutable
class CustomDatatable extends StatefulWidget {
  CustomDatatable(
      {Key? key,
      this.columnWidth,
      required this.columns,
      this.circle = false,
      this.columnDecoration,
      this.showCheckbox = false,
      required this.rows,
      this.columnHeight = 50,
      this.rowHeight = 50})
      : super(key: key) {
    columnWidth ??= List.filled(columns.length, null);
  }
  List<double?>? columnWidth;
  final List<ColumnItem> columns;
  final bool circle;
  final BoxDecoration? columnDecoration;
  final bool showCheckbox;
  final List<CustomTableRow> rows;
  final double columnHeight;
  final double rowHeight;

  @override
  State<CustomDatatable> createState() => _CustomDatatableState();
}

class _CustomDatatableState extends State<CustomDatatable> {
  late ValueNotifier<TableStatus> selectStatus = widget.showCheckbox
      ? ValueNotifier(TableStatus(
          selectStatus: SelectStatus.zero, rowLength: widget.rows.length))
      : ValueNotifier(TableStatus(
          selectStatus: SelectStatus.none, rowLength: widget.rows.length));

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, value, Widget? child) {
        return Column(
          children: [
            DataTableColumn(
              columnHeight: widget.columnHeight,
              decoration: widget.columnDecoration,
              columns: widget.columns,
              status: selectStatus,
              columnWidth: widget.columnWidth!,
            ),
            ...widget.rows
                .mapIndexed((i, e) => DataTableRow(
                    rowHeight: widget.rowHeight,
                    dataCells: e.dataCells,
                    status: selectStatus,
                    index: i,
                    columnWidth: widget.columnWidth!))
                .toList()
          ],
        );
      },
      valueListenable: selectStatus,
    );
  }
}
