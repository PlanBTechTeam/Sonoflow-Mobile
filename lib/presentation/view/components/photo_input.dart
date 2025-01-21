import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/// Widget que permite selecionar uma imagem da galeria e exibi-la
/// em um contêiner circular. Exibe um ícone padrão caso nenhuma
/// imagem seja escolhida.
class ImagePickerWidget extends StatelessWidget {
  final File? image;
  final void Function(File?) onImagePicked;

  const ImagePickerWidget({
    super.key,
    required this.image,
    required this.onImagePicked,
  });

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      onImagePicked(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(100),
            ),
            width: 150,
            height: 150,
            child: image == null
                ? const Icon(Icons.add_a_photo, size: 50)
                : ClipOval(
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
