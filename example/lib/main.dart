import 'package:fat_widgets_example/sidemenus/multi_level.dart';
import 'package:fat_widgets_example/sidemenus/multi_level_single_destination.dart';
import 'package:fat_widgets_example/sidemenus/resizable.dart';
import 'package:flutter/material.dart';

import 'sidemenus/animated.dart';
import 'sidemenus/custom_clipper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: Routers.routers,
    );
  }
}

class Routers {
  static String customClipperSidemenu = "/customClipperSidemenu";
  static String customResiableSidemenu = "/customResiableSidemenu";
  static String animatedSidemenu = "/animatedSidemenu";
  static String multiLevel = "/multiLevel";
  static String multiLevel2 = "/multiLevel2";

  static Map<String, WidgetBuilder> routers = {
    customClipperSidemenu: (context) => const CustomClipperSidemenu(),
    customResiableSidemenu: (context) => CustomResizableSidemenu(),
    animatedSidemenu: (context) => const AnimatedClipperSidemenu(),
    multiLevel: (context) => MultilevelSidemenu(),
    multiLevel2: (context) => MultilevelSingleDestinationSidemenu()
  };
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sidemenus",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          _wrapper(Routers.customClipperSidemenu, context),
          _wrapper(Routers.customResiableSidemenu, context),
          _wrapper(Routers.animatedSidemenu, context),
          _wrapper(Routers.multiLevel, context),
          _wrapper(Routers.multiLevel2, context),
        ],
      ),
    );
  }

  Widget _wrapper(String text, BuildContext context) {
    final t = text.replaceAll("/", "");
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(text);
          },
          trailing: const Icon(Icons.navigation),
          title: Text(t),
        ),
      ),
    );
  }
}
