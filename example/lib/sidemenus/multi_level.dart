// ignore_for_file: avoid_print

import 'package:fat_widgets/fat_widgets.dart';
import 'package:flutter/material.dart';

class MultilevelSidemenu extends StatelessWidget {
  MultilevelSidemenu({super.key});

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
        title: const Text("CustomClipperSidemenu"),
        centerTitle: true,
      ),
      body: MultiLevelSideMenu(
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
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: Text('Wishlist'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person),
            label: Text('Account'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: Text('Cart'),
          ),
        ],
        onDestinationSelected: (i) {
          print(i);
        },
      ),
    );
  }
}
