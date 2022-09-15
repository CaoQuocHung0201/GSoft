import 'package:flutter/material.dart';
import 'package:testlogin/subdashboard/menubar.dart';
class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: const Drawer(
          child: MenuBar(),
        ),
      ),
    );
  }
}
