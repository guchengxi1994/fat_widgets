import 'package:flutter/material.dart';

typedef OnItemClicked = Function(int);

class BaseSidemenuData {
  final double width;
  final double height;
  final int index;

  final Color onHoverColor;
  final Color selectedColor;
  final Widget title;
  final Widget? leading;
  final OnItemClicked onItemClicked;

  BaseSidemenuData(
      {required this.height,
      required this.width,
      required this.index,
      this.onHoverColor = Colors.blueGrey,
      this.selectedColor = Colors.blue,
      required this.title,
      this.leading,
      required this.onItemClicked});

  Widget toWidget(ValueNotifier<int> valueNotifier) {
    return BaseSidemenuItem(data: this, valueNotifier: valueNotifier);
  }
}

class BaseSidemenuItem extends StatelessWidget {
  const BaseSidemenuItem(
      {Key? key, required this.data, required this.valueNotifier})
      : super(key: key);
  final ValueNotifier<int> valueNotifier;
  final BaseSidemenuData data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 25),
      width: data.width,
      height: data.height,
      child: ListTile(
        tileColor: valueNotifier.value == data.index
            ? data.selectedColor
            : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        contentPadding: EdgeInsets.zero,
        title: data.title,
        leading: data.leading,
        hoverColor: data.onHoverColor,
        // selectedColor: data.selectedColor,
        onTap: () {
          valueNotifier.value = data.index;
          data.onItemClicked(data.index);
        },
      ),
    );
  }
}
