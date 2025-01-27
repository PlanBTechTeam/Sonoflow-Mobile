import 'package:flutter/material.dart';
import 'package:sonoflow/presentation/utils/colors.dart';

/// WELCOME WIDGET
///
/// Um widget que exibe uma mensagem de boas-vindas personalizada ao usuário.
///
/// Este widget possui dois parâmetros:
/// - [username]: O nome do usuário que será exibido na mensagem de boas-vindas.
/// - [photoURL]: O URL da imagem do usuário que será exibida como foto de perfil.
class WelcomeWidget extends StatelessWidget {
  final String username; // Nome do usuário
  final String photoURL; // URL da imagem do usuário

  const WelcomeWidget({
    super.key,
    required this.username,
    required this.photoURL,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(photoURL),
        ),
        const SizedBox(width: 10), // Espaçamento entre a imagem e o texto
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Olá $username",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              "Bem-vindo ao seu diário do sono",
              style: TextStyle(color: AppColors.mediumGray),
            ),
          ],
        ),
      ],
    );
  }
}
