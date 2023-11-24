import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
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
  LatLng? _pickedPosition;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _selectImage(File pickedImage) =>
      setState(() => _pickedImage = pickedImage);

  void _selectPosition(LatLng pickedPosition) =>
      setState(() => _pickedPosition = pickedPosition);

  bool _isValidForm() =>
      _titleController.text.isNotEmpty &&
      _pickedImage != null &&
      _pickedPosition != null;

  void _submitForm() {
    if (!_isValidForm()) return;

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
        title: _titleController.text,
        image: _pickedImage!,
        position: _pickedPosition!);

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
                      onChanged: (_) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 10),
                    ImageInput(selectImage: _selectImage),
                    const SizedBox(height: 10),
                    LocationInput(selectPosition: _selectPosition)
                  ],
                ),
              ),
            ),
            FilledButton.icon(
                style: FilledButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                    shape: const RoundedRectangleBorder()),
                onPressed: _isValidForm() ? _submitForm : null,
                icon: const Icon(Icons.add),
                label: const Text("Adicionar"))
          ],
        ));
  }
}
