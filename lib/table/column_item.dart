import 'package:flutter/material.dart';

typedef OnSort = void Function(bool ascending);

class ColumnItem extends StatelessWidget {
  ColumnItem({Key? key, required this.label, this.tooltip, this.onSort})
      : super(key: key);
  final Widget label;
  final String? tooltip;
  final OnSort? onSort;

  final ValueNotifier<bool> notifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: notifier,
        builder: (c, b, w) {
          return Material(
            child: InkWell(
              onTap: onSort != null
                  ? () {
                      notifier.value = !notifier.value;
                      onSort!(notifier.value);
                    }
                  : null,
              child: FittedBox(
                child: Tooltip(
                  message: tooltip ?? "",
                  child: Row(
                    children: [
                      label,
                      if (onSort != null)
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
