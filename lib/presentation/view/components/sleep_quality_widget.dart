import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sonoflow/presentation/utils/colors.dart';

class SleepQualityWidget extends StatelessWidget {
  final double value;
  const SleepQualityWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16), // Arredondar os cantos
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), // Cor da sombra
              offset: const Offset(0, 4), // Deslocamento da sombra
              blurRadius: 8, // Raio de desfoque
              spreadRadius: 1, // Tamanho da sombra
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Qualidade do sono",
                style: TextStyle(
                  color: AppColors.midnightBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16), // Espaço entre o texto e o gráfico
              CircularPercentIndicator(
                radius: 50, // Tamanho do gráfico
                lineWidth: 8.0, // Espessura da linha
                animation: true,
                percent: value / 100, // Porcentagem com base no valor (0 a 1)
                center: Text(
                  "${value.toString()}%", // Texto central
                  style: const TextStyle(
                    color: AppColors.goldenYellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                progressColor: AppColors.goldenYellow, // Cor do progresso
                backgroundColor: Colors.grey[200]!, // Cor de fundo do gráfico
                circularStrokeCap: CircularStrokeCap.round,
                // Borda dourada
              ),
            ],
          ),
        ),
      ),
    );
  }
}
