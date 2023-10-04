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
      this.rowHeight = 50,
      this.ifEmpty = const Text("No Data"),
      this.onSingleRowSelectedChanged,
      this.onSelectedAllStatusChanged})
      : super(key: key) {
    columnWidth ??= List.filled(columns.length, null);
    assert(columnWidth!.length == columns.length);
    if (rows.isNotEmpty) {
      assert(rows.first.dataCells.length == columns.length);
    }
  }
  List<double?>? columnWidth;
  final List<ColumnItem> columns;
  final bool circle;
  final BoxDecoration? columnDecoration;
  final bool showCheckbox;
  final List<CustomTableRow> rows;
  final double columnHeight;
  final double rowHeight;
  final Widget ifEmpty;
  final OnSingleRowSelectedStatusChanged? onSingleRowSelectedChanged;
  final OnSelectedAllStatusChanged? onSelectedAllStatusChanged;

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
              onSelectedAllStatusChanged: (rows) {
                if (widget.onSelectedAllStatusChanged != null) {
                  widget.onSelectedAllStatusChanged!(rows);
                }
              },
              columnHeight: widget.columnHeight,
              decoration: widget.columnDecoration,
              columns: widget.columns,
              status: selectStatus,
              columnWidth: widget.columnWidth!,
            ),
            if (widget.rows.isEmpty)
              Center(
                child: widget.ifEmpty,
              ),
            ...widget.rows
                .mapIndexed((i, e) => DataTableRow(
                    onSingleRowSelectedChanged: (index) {
                      if (widget.onSingleRowSelectedChanged != null) {
                        widget.onSingleRowSelectedChanged!(index);
                      }
                    },
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
