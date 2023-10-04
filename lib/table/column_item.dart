import 'package:flutter/material.dart';

typedef OnSort = void Function(bool ascending);

class ColumnItem extends StatefulWidget {
  const ColumnItem({Key? key, required this.label, this.tooltip, this.onSort})
      : super(key: key);
  final Widget label;
  final String? tooltip;
  final OnSort? onSort;

  @override
  State<ColumnItem> createState() => _ColumnItemState();
}

class _ColumnItemState extends State<ColumnItem> {
  final ValueNotifier<bool> notifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: notifier,
        builder: (c, b, w) {
          return Material(
            child: InkWell(
              onTap: widget.onSort != null
                  ? () {
                      notifier.value = !notifier.value;
                      widget.onSort!(notifier.value);
                    }
                  : null,
              child: FittedBox(
                child: Tooltip(
                  message: widget.tooltip ?? "",
                  child: Row(
                    children: [
                      widget.label,
                      if (widget.onSort != null)
                        notifier.value
                            ? const Icon(Icons.arrow_downward)
                            : const Icon(Icons.arrow_upward)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
