import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Visibility(
              visible: _previewImageUrl.isNotEmpty,
              replacement: const Text('Localização não informada!'),
              child: Image.network(
                _previewImageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              )),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.my_location),
                label: const Text('Localização Atual')),
            const SizedBox(width: 10),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: const Text('Selecione no Mapa'))
          ],
        )
      ],
    );
  }
}
