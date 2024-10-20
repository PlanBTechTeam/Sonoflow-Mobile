import 'package:flutter/material.dart';
import 'package:sonoflow/presentation/view/components/sleep_diary_widget.dart';
import 'package:sonoflow/presentation/view/components/sleep_quality_widget.dart';
import 'package:sonoflow/presentation/view/components/welcome_widget.dart';
import 'package:sonoflow/presentation/utils/colors.dart';

/// HOME SCREEN
///
/// A tela inicial do aplicativo que exibe os seguintes widgets:
/// - **Welcome Widget**: Exibe uma mensagem de boas-vindas com o nome do usuário e a foto.
/// - **Sleep Widget**: Pergunta ao usuário se ele já preencheu seu diário do sono hoje.
///
/// Esta tela é organizada em uma coluna que alinha os
/// widgets na parte inferior da tela.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            color: AppColors.ghostWhite,
          ),
          child: const Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== WELCOME WIDGET =====
                  WelcomeWidget(
                    username: "João Gabriel",
                    photoURL: "assets/public/img_default.png",
                  ),

                  SizedBox(height: 20),

                  // ===== SLEEP DIARY =====
                  Text("Diário do Sono",
                      style: TextStyle(
                        color: AppColors.midnightBlue,
                        fontWeight: FontWeight.bold,
                      )),

                  SleepDiaryWidget(),

                  SizedBox(height: 20),

                  // ===== LAST METRICS =====
                  Text("Métricas dos últimos 7 dias",
                      style: TextStyle(
                        color: AppColors.midnightBlue,
                        fontWeight: FontWeight.bold,
                      )),

                  SizedBox(height: 20),

                  Row(
                    children: [
                      SleepQualityWidget(
                        value: 64,
                      ),
                      SizedBox(width: 30),
                      SleepQualityWidget(
                        value: 10,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
