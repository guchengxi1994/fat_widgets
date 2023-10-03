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
            circle: true,
            status: ValueNotifier(TableStatus(selectStatus: SelectStatus.some)),
            columns: [
              ColumnItem(
                label: const Text("test"),
                onSort: null,
              )
            ],
          ),
          const Divider(),
          Expanded(
              child: CustomDatatable(
            circle: true,
            showCheckbox: true,
            columns: [
              ColumnItem(
                label: const Text("test"),
                onSort: null,
              )
            ],
            rows: [
              CustomTableRow(dataCells: [const Text("table item1")]),
              CustomTableRow(dataCells: [const Text("table item2")])
            ],
          ))
        ],
      ),
    );
  }
}
