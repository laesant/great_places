import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.selectImage});
  final void Function(File) selectImage;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  _takePicture() async {
    final ImagePicker picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile != null) {
      setState(() {
        _storedImage = File(imageFile.path);
      });

      Directory appDir = await getApplicationDocumentsDirectory();
      String fileName = basename(_storedImage!.path);
      final File savedImage =
          await _storedImage!.copy('${appDir.path}/$fileName');
      widget.selectImage(savedImage);
    }
  }

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
              image: _storedImage != null
                  ? DecorationImage(
                      fit: BoxFit.cover, image: FileImage(_storedImage!))
                  : null),
          child: _storedImage == null ? const Text("Nenhuma image!") : null,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 19),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            onPressed: _takePicture,
            label: const Text(
              "Tirar Foto",
            ),
            icon: const Icon(Icons.camera),
          ),
        )
      ],
    );
  }
}
