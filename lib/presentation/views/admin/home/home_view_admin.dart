import 'package:flutter/material.dart';

class HomeViewAdmin extends StatefulWidget {
  const HomeViewAdmin({super.key});

  @override
  State<HomeViewAdmin> createState() => _HomeViewAdminState();
}

class _HomeViewAdminState extends State<HomeViewAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home admin"),
      ),
    );
  }
}