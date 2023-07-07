// ignore_for_file: avoid_print

import 'package:fat_widgets/fat_widgets.dart';
import 'package:flutter/material.dart';

class CustomResizableSidemenu extends StatelessWidget {
  CustomResizableSidemenu({super.key});

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("ResizableSidemenu"),
        centerTitle: true,
      ),
      body: ResizableSidemenu(
        height: MediaQuery.of(context).size.height,
        minWidth: 300,
        items: List.generate(
            5,
            (index) => BaseSidemenuData(
                leading: const Icon(
                  Icons.abc,
                  size: 25,
                ),
                padding: const EdgeInsets.only(bottom: 12, left: 10),
                height: 60,
                width: 280,
                index: index,
                onItemClicked: (p0) {
                  print(p0);
                  controller.jumpToPage(p0);
                },
                title: Text(index.toString()))).toList(),
        pageView: PageView(
          controller: controller,
          children: List.generate(
              5,
              (index) => Center(
                    child: Text(index.toString()),
                  )),
        ),
      ),
    );
  }
}
