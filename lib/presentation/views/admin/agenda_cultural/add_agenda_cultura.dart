import 'package:flutter/material.dart';

class AddAgendaCultura extends StatefulWidget {
  const AddAgendaCultura({super.key});

  @override
  State<AddAgendaCultura> createState() => _AddAgendaCulturaState();
}

class _AddAgendaCulturaState extends State<AddAgendaCultura> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar'),
      ),
    );
  }
}