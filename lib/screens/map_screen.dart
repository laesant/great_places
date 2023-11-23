import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.isReadOnly = false,
    this.initialLocation = const PlaceLocation(
      latitude: 37.422131,
      longitude: -122.084801,
    ),
  });
  final PlaceLocation initialLocation;
  final bool isReadOnly;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;

  void _selectPosition(LatLng position) =>
      setState(() => _pickedPosition = position);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione...'),
      ),
      body: GoogleMap(
        onTap: widget.isReadOnly ? null : _selectPosition,
        markers: _pickedPosition == null
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('p1'),
                  position: _pickedPosition!,
                )
              },
        initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.initialLocation.latitude,
              widget.initialLocation.longitude,
            ),
            zoom: 13),
      ),
    );
  }
}