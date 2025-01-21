import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/// Widget que permite selecionar uma imagem da galeria e exibi-la
/// em um contêiner circular. Exibe um ícone padrão caso nenhuma
/// imagem seja escolhida.
class PhotoInput extends StatelessWidget {
  final File? image;
  final void Function(File?) onImagePicked;

  const PhotoInput({
    super.key,
    required this.image,
    required this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _showSourceSelectionDialog(context),
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

  void _showSourceSelectionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Tire uma foto'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Escolha da Galeria'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      onImagePicked(imageFile);
    }
  }
}
