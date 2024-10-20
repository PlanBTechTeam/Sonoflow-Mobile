import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonoflow/presentation/utils/colors.dart';
import 'package:sonoflow/presentation/viewmodel/change_layer_viewmodel.dart';

/// Widget responsável por exibir um slider customizado para controlar o progresso
/// entre as camadas (layers) do aplicativo.
///
/// O slider é interativo, permitindo ao usuário navegar entre diferentes
/// camadas usando setas laterais. O progresso visual é calculado dinamicamente
/// com base no valor atual da camada (`layer`), e está limitado entre os
/// valores mínimos e máximos (`minLayer` e `maxLayer`) definidos no viewmodel.
class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ChangeLayerViewmodel layerViewModel =
        Provider.of<ChangeLayerViewmodel>(context);

    return Row(
      children: [
        /// Botão à esquerda para retroceder uma camada.
        Opacity(
          opacity: layerViewModel.layer != layerViewModel.minLayer + 1 ? 1 : 0,
          child: GestureDetector(
            onTap: () {
              layerViewModel.previousLayer();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.steelBlue,
                  border: Border.all(
                      color: AppColors.softSkyBlueGradient, width: 2),
                  borderRadius: BorderRadius.circular(16)),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Image(image: AssetImage("assets/icons/arrow_left.png")),
              ),
            ),
          ),
        ),

        const SizedBox(width: 20),

        /// Área do slider que reflete o progresso entre as camadas.
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(94, 105, 128, 0.21),
                    borderRadius: BorderRadius.circular(30)),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  // Largura máxima disponível para a barra de progresso.
                  final double maxBarWidth = constraints.maxWidth;

                  final double progress = ((layerViewModel.layer -
                              layerViewModel.minLayer) /
                          (layerViewModel.maxLayer - layerViewModel.minLayer)) *
                      maxBarWidth;

                  return Container(
                    width: progress,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromRGBO(201, 169, 107, 1),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(width: 20),

        /// Botão à direita para avançar para a próxima camada.
        Opacity(
          opacity: layerViewModel.layer != layerViewModel.maxLayer ? 1 : 0,
          child: GestureDetector(
            onTap: () {
              layerViewModel.nextLayer();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.steelBlue,
                  border:
                      Border.all(color: AppColors.softSkyBlueGradient, width: 2),
                  borderRadius: BorderRadius.circular(16)),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Image(image: AssetImage("assets/icons/arrow_right.png")),
              ),
            ),
          ),
        )
      ],
    );
  }
}
