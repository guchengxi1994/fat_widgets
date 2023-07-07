// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Spinnig Menu",
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: const Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[CustomThemedRadialMenu()],
          ),
        ),
      ),
    );
  }
}

class CustomThemedRadialMenu extends StatefulWidget {
  const CustomThemedRadialMenu({super.key});

  @override
  _CustomThemedRadialMenuState createState() => _CustomThemedRadialMenuState();
}

class _CustomThemedRadialMenuState extends State<CustomThemedRadialMenu>
    with SingleTickerProviderStateMixin {
  late Animation animationOpenClose;
  late AnimationController animationControllerOpenClose;

  late bool isOpen;

  @override
  void initState() {
    isOpen = false;
    animationControllerOpenClose =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animationOpenClose = Tween(begin: 0.0, end: 3.14159 * 2)
        .animate(animationControllerOpenClose);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///A list of the items and the center menu button
    final List<Widget> menuContents = <Widget>[];

    ///Menu Close/Open button
    menuContents.add(InkWell(
      onTap: () {
        if (isOpen) {
          closeMenu();
        } else {
          openMenu();
        }
      },
      child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black38),
            shape: BoxShape.circle,
          ),
          child: AnimatedBuilder(
            animation: animationControllerOpenClose,
            builder: (context, child) {
              return Transform.rotate(
                  angle: animationOpenClose.value, child: child);
            },
            child: isOpen ? const Icon(Icons.clear) : const Icon(Icons.menu),
          )),
    ));

    return Stack(
      alignment: Alignment.center,
      children: menuContents,
    );
  }

  @override
  void dispose() {
    animationControllerOpenClose.dispose();

    super.dispose();
  }

  closeMenu() {
    animationControllerOpenClose.forward(from: 0.0);
    setState(() {
      isOpen = false;
    });

    print("RadialMenu Closed");
  }

  openMenu() {
    animationControllerOpenClose.forward(from: 0.0);
    setState(() {
      isOpen = true;
    });

    print("RadialMenu Opened");
  }
}
