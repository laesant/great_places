import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: const Text("Nenhuma image!"),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 19),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            onPressed: () {},
            label: const Text(
              "Tirar Fotos",
            ),
            icon: const Icon(Icons.camera),
          ),
        )
      ],
    );
  }
}
