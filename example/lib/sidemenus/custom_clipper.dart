// ignore_for_file: avoid_print

import 'package:fat_widgets/fat_widgets.dart';
import 'package:flutter/material.dart';

class CustomClipperSidemenu extends StatelessWidget {
  const CustomClipperSidemenu({super.key});

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
        title: const Text("CustomClipperSidemenu"),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SingleLevelSidemenu<BaseSidemenuData>(
            /* if indicatorSize set to 0, then it is a normal sidemenu */
            indicatorSize: 30,
            height: MediaQuery.of(context).size.height,
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
                    },
                    title: Text(index.toString()))).toList(),
            width: 300,
          )
        ],
      ),
    );
  }
}
