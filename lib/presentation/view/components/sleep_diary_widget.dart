import 'package:flutter/material.dart';
import 'package:sonoflow/presentation/utils/colors.dart';
import 'package:sonoflow/presentation/view/diary/diary_screen.dart';
import 'package:sonoflow/presentation/view/home/home_screen.dart';
import 'package:sonoflow/presentation/view/settings/setting_screen.dart';

/// SLEEP DIARY WIDGET
///
/// Um widget que exibe uma mensagem perguntando ao usuário se ele
/// já realizou seu diário do sono hoje. O widget é composto por um
/// texto estilizado e um botão que pode ser usado para navegar
/// ou realizar uma ação.
class SleepDiaryWidget extends StatelessWidget {
  const SleepDiaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: AppColors.linearBlueGradient,
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          children: [
                            TextSpan(text: "Já realizou o seu "),
                            TextSpan(
                              text: "diário do sono ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "hoje?"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DiaryScreen()));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.goldenYellow),
                        ),
                        child: const Text(
                          "Responder",
                          style: TextStyle(color: AppColors.midnightBlue),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0, // Ajuste aqui para mover a imagem para cima
          right: -15, // Ajusta a posição horizontal da imagem
          child: Image(
            image: AssetImage("assets/public/img_sleep_diary_man_vector.png"),
            height: 200,
          ),
        ),
      ],
    );
  }
}
