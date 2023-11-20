import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Meus Lugares"),
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.placeForm),
                icon: const Icon(Icons.add))
          ],
        ),
        body: Consumer<GreatPlaces>(
          child: const Center(
            child: Text('Nenhum local cadastrado'),
          ),
          builder: (context, value, child) => Visibility(
            visible: value.itemsCount > 0,
            replacement: child!,
            child: ListView.builder(
              itemCount: value.itemsCount,
              itemBuilder: (context, index) => ListTile(
                onTap: () {},
                leading: CircleAvatar(
                  backgroundImage: FileImage(value.itemByIndex(index).image),
                ),
                title: Text(value.itemByIndex(index).title),
              ),
            ),
          ),
        ));
  }
}
