import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final myDrawerKey;
  const Button1(this.myDrawerKey, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (1 / 6),
      child: IconButton(
        icon: const Icon(
          Icons.menu_rounded,
          size: 34,
          color: Color.fromRGBO(255, 0, 0, 1),
        ),
        // highlight color is used to block grey flash on Tap
        highlightColor: Colors.white,
        onPressed: () {
          myDrawerKey.currentState.openDrawer();
          // _drawerKey.currentState.openDrawer()
        },
      ),
    );
  }
}
