import 'package:fat_widgets/table/column_item.dart';
import 'package:fat_widgets/table/columns.dart';
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
            status: ValueNotifier(SelectStatus.none),
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
            status: ValueNotifier(SelectStatus.all),
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
            status: ValueNotifier(SelectStatus.some),
            columns: [
              ColumnItem(
                label: const Text("test"),
                onSort: null,
              )
            ],
          )
        ],
      ),
    );
  }
}
