import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.selectPosition});
  final void Function(LatLng) selectPosition;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl = '';

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() => _previewImageUrl = staticMapImageUrl);
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final LocationData locData = await Location().getLocation();
      _showPreview(locData.latitude!, locData.longitude!);
      widget.selectPosition(LatLng(locData.latitude!, locData.longitude!));
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedPosition = await Navigator.of(context).push(
        MaterialPageRoute(
            fullscreenDialog: true, builder: (context) => const MapScreen()));

    if (selectedPosition == null) return;
    _showPreview(selectedPosition.latitude, selectedPosition.longitude);
    widget.selectPosition(selectedPosition);
  }

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
                onPressed: _getCurrentUserLocation,
                icon: const Icon(Icons.my_location),
                label: const Text('Localização Atual')),
            const SizedBox(width: 10),
            ElevatedButton.icon(
                onPressed: _selectOnMap,
                icon: const Icon(Icons.map),
                label: const Text('Selecione no Mapa'))
          ],
        )
      ],
    );
  }
}
