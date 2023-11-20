import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _selectImage(File pickedImage) => _pickedImage = pickedImage;

  void _submitForm() {
    if (_titleController.text.isEmpty || _pickedImage == null) return;
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(title: _titleController.text, image: _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // elevation: 8,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Novo Lugar"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Título',
                      ),
                    ),
                    const SizedBox(height: 10),
                    ImageInput(selectImage: _selectImage)
                  ],
                ),
              ),
            ),
            FilledButton.icon(
                style: FilledButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                    shape: const RoundedRectangleBorder()),
                onPressed: _submitForm,
                icon: const Icon(Icons.add),
                label: const Text("Adicionar"))
          ],
        ));
  }
}
