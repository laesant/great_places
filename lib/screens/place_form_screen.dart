import 'package:flutter/material.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 8,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Novo Lugar"),
      ),
      body: const Center(
        child: Text("Form"),
      ),
    );
  }
}