// ignore_for_file: avoid_print

import 'package:fat_widgets/table/column_item.dart';
import 'package:fat_widgets/table/columns.dart';
import 'package:fat_widgets/table/custom_data_table.dart';
import 'package:fat_widgets/table/rows.dart';
import 'package:fat_widgets/table/table_status.dart';
import 'package:flutter/material.dart';

class TableExample extends StatefulWidget {
  const TableExample({Key? key}) : super(key: key);

  @override
  State<TableExample> createState() => _TableExampleState();
}

class _TableExampleState extends State<TableExample> {
  late List<CustomTableRow> rows = [
    CustomTableRow(
        dataCells: [const Text("table item1"), const Text("table item  r1")]),
    CustomTableRow(
        dataCells: [const Text("table item2"), const Text("table item  r2")])
  ];

  late List<CustomTableRow> rows2 = [
    CustomTableRow(dataCells: [
      const Text("2 -- table item1"),
      const Text("2 -- table item  r1")
    ]),
    CustomTableRow(dataCells: [
      const Text("2 -- table item2"),
      const Text("2 -- table item  r2")
    ])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ColumnItem(
            label: const Text("test"),
            onSort: (ascending) {
              print(ascending);
            },
          ),
          DataTableColumn(
            columnWidth: const [50.0],
            status: ValueNotifier(TableStatus()),
            columns: [
              ColumnItem(
                label: const Text("test"),
                onSort: (ascending) {
                  print(ascending);
                },
              )
            ],
          ),
          DataTableColumn(
            columnWidth: const [50.0],
            status: ValueNotifier(TableStatus(selectStatus: SelectStatus.all)),
            columns: [
              ColumnItem(
                label: const Text("test"),
                onSort: (ascending) {
                  print(ascending);
                },
              )
            ],
          ),
          DataTableColumn(
            columnWidth: const [50.0],
            circle: true,
            status: ValueNotifier(TableStatus(selectStatus: SelectStatus.some)),
            columns: const [
              ColumnItem(
                label: Text("test"),
                onSort: null,
              )
            ],
          ),
          const Divider(),
          Expanded(
              child: CustomDatatable(
            columnWidth: const [200, null],
            onSelectedAllStatusChanged: (rows) {
              print(rows);
            },
            onSingleRowSelectedChanged: (index) {
              print(index);
            },
            columnHeight: 50,
            rowHeight: 30,
            circle: true,
            showCheckbox: true,
            columns: [
              const ColumnItem(
                label: Text("test"),
                onSort: null,
              ),
              ColumnItem(
                label: const Text("test2"),
                onSort: (b) {
                  setState(() {
                    rows = rows.reversed.toList();
                  });
                },
              )
            ],
            rows: rows,
          )),
          Expanded(
              child: CustomDatatable(
            columnDecoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(15)),
            columnWidth: const [200, null],
            onSelectedAllStatusChanged: (rows) {
              print(rows);
            },
            onSingleRowSelectedChanged: (index) {
              print(index);
            },
            columnHeight: 50,
            rowHeight: 30,
            circle: true,
            showCheckbox: true,
            columns: [
              const ColumnItem(
                label: Text("2 -- test"),
                onSort: null,
              ),
              ColumnItem(
                label: const Text("2 -- test2"),
                onSort: (b) {
                  setState(() {
                    rows2 = rows2.reversed.toList();
                  });
                },
              )
            ],
            rows: rows2,
          ))
        ],
      ),
    );
  }
}
