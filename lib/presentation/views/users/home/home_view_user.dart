import 'package:flutter/material.dart';

class HomeViewUser extends StatefulWidget {
  const HomeViewUser({super.key});

  @override
  State<HomeViewUser> createState() => _HomeViewUserState();
}

class _HomeViewUserState extends State<HomeViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME USUARIO"),
      ),
    );
  }
}