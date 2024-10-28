import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonoflow/models/input_type.dart';
import 'package:sonoflow/presentation/utils/colors.dart';
import 'package:sonoflow/presentation/view/components/slider_widget.dart';
import 'package:sonoflow/presentation/view/diary/components/diary_card_widget.dart';
import 'package:sonoflow/presentation/viewmodel/change_layer_viewmodel.dart';
import 'package:sonoflow/presentation/viewmodel/diarycard_viewmodel.dart';

/// DIARY SCREEN
///
/// A tela principal do diário do sono, que permite ao usuário preencher
/// seu diário para ajudar a melhorar a qualidade do sono.
/// - Exibe uma AppBar personalizada com o título baseado no estado atual.
/// - Dependendo do estado, exibe diferentes camadas (layers) da interface,
///   começando com uma mensagem de boas-vindas e um botão para iniciar o questionário.
/// - O SliderWidget é exibido na segunda camada (quando o questionário é iniciado).
class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  String _sleepDate = DateTime.now().toString().split(" ")[0];
  final ValueNotifier<String> _bedtime = ValueNotifier('00:00');
  final ValueNotifier<String> _sleepAttemptTime = ValueNotifier('00:00');
  final ValueNotifier<String> _wakeUpTime = ValueNotifier('00:00');
  final ValueNotifier<String> _lastWakeUpTime = ValueNotifier('00:00');

  final String _timeToFallAsleep = 'Menos de 5 minutos';
  final String _timeToFallAsleepAgain = 'Menos de 5 minutos';

  int _nightAwakenings = 0;

  final List<String> _techniquesUsedToday = [];
  final List<String> _positiveFactorsToday = [];
  final List<String> _negativeFactorsToday = [];
  final List<String> _sleepFactors = [];

  double _anxietyComparisonToday = 50;
  double _fatigueReduction = 50;
  final double _stressComparisonToday = 50;
  double _morningFeeling = 50;

  bool _medicationUsageYesterday = false;
  final TextEditingController _additionalComments = TextEditingController();
  double _sleepFlowDedication = 50;

  @override
  Widget build(BuildContext context) {
    // Obtém o ViewModel que gerencia as camadas da interface
    ChangeLayerViewmodel layerViewModel =
        Provider.of<ChangeLayerViewmodel>(context);

    // Obtém o ViewModel que gerencia os cartões do diário
    DiaryCardViewModel cardViewModel = Provider.of<DiaryCardViewModel>(context);

    final List<Map<String, dynamic>> cards = [
      // LAYER 1
      // Data do Sono
      {
        'layer': 1,
        'title': 'Data do Sono',
        'value': _sleepDate,
        'type': InputType.date,
        'onPressed': () {
          _selectSleepDate(context);
        }
      },
      // A que horas você foi para cama?
      {
        'layer': 1,
        'title': 'A que horas você foi para cama?',
        'value': _bedtime.value,
        'type': InputType.time,
        'onPressed': () {
          _selectTime(context, _bedtime);
        }
      },
      // Depois de ir para a cama, qual foi o horário que você decidiu tentar dormir?
      {
        'layer': 1,
        'title':
            'Depois de ir para a cama, qual foi o horário que você decidiu tentar dormir?',
        'value': _sleepAttemptTime.value,
        'type': InputType.time,
        'onPressed': () {
          _selectTime(context, _sleepAttemptTime);
        },
      },

      // LAYER 2
      // Quanto tempo você acha que demorou até pegar no sono?
      {
        'layer': 2,
        'title': 'Quanto tempo você acha que demorou até pegar no sono?',
        'value': _timeToFallAsleep,
        'type': InputType.select,
        'options': const [
          'Menos de 5 minutos',
          'Menos de 10 minutos',
          'Menos de 15 minutos',
          'Menos de 20 minutos',
          'Mais de 20 minutos',
          'Mais de 30 minutos',
          'Mais de 40 minutos',
          'Mais de 50 minutos',
          'Mais de 60 minutos',
        ],
      },
      // Quantas vezes você acordou durante a noite?
      {
        'layer': 2,
        'title': 'Quantas vezes você acordou durante a noite?',
        'value': _nightAwakenings.toString(),
        'type': InputType.count,
        'onPressed': () {
          setState(() {
            if (_nightAwakenings > 0) {
              _nightAwakenings--;
            }
          });
        },
        'onPressed2': () {
          setState(() {
            _nightAwakenings++;
          });
        },
      },
      // Quanto tempo você acha que demorou até pegar no sono novamente?
      {
        'layer': 2,
        'title':
            'Quanto tempo você acha que demorou até pegar no sono novamente?',
        'value': _timeToFallAsleepAgain,
        'type': InputType.select,
        'options': const [
          'Menos de 5 minutos',
          'Menos de 10 minutos',
          'Menos de 15 minutos',
          'Menos de 20 minutos',
          'Mais de 20 minutos',
          'Mais de 30 minutos',
          'Mais de 40 minutos',
          'Mais de 50 minutos',
          'Mais de 60 minutos',
        ],
      },

      // LAYER 3
      // A que horas você acordou pela última vez?
      {
        'layer': 3,
        'title': 'A que horas você acordou pela última vez?',
        'value': _lastWakeUpTime.value,
        'type': InputType.date,
        'onPressed': () {
          _selectTime(context, _lastWakeUpTime);
        }
      },
      // A que horas você levantou da cama
      {
        'layer': 3,
        'title': 'A que horas você levantou da cama',
        'value': _wakeUpTime.value,
        'type': InputType.date,
        'onPressed': () {
          _selectTime(context, _wakeUpTime);
        }
      },

      // LAYER 4
      // Comparado ao dia de ontem, como está sua ansiedade hoje?
      {
        'layer': 4,
        'title': 'Comparado ao dia de ontem, como está sua ansiedade hoje?',
        'doubleValue': _anxietyComparisonToday,
        'type': InputType.slider,
        'sliderIcon_1': "🧘‍- ansioso",
        'sliderIcon_2': "😯 + ansioso",
        'doubleonChange': (newValue) {
          setState(() {
            _anxietyComparisonToday = newValue;
          });
        },
      },
      // O quanto o seu cansaço diminuiu de ontem para hoje
      {
        'layer': 4,
        'title': 'O quanto o seu cansaço diminuiu de ontem para hoje',
        'doubleValue': _fatigueReduction,
        'type': InputType.slider,
        'sliderIcon_1': '😎 - cansaço',
        'sliderIcon_2': '🥵 + cansaço',
        'doubleonChange': (newValue) {
          setState(() {
            _fatigueReduction = newValue;
          });
        },
      },

      // LAYER 5
      // Em relação a ontem como você se sente em relação ao estresse
      {
        'layer': 5,
        'title': 'Em relação a ontem como você se sente em relação ao estresse',
        'doubleValue': _stressComparisonToday,
        'type': InputType.slider,
        'sliderIcon_1': '😊 - estresse',
        'sliderIcon_2': '😡 + estresse',
        'doubleonChange': (newValue) {
          setState(() {
            _fatigueReduction = newValue;
          });
        },
      },
      // Como você se sente ao acordar hoje?
      {
        'layer': 5,
        'title': 'Como você se sente ao acordar hoje?',
        'doubleValue': _morningFeeling,
        'type': InputType.slider,
        'sliderIcon_1': '🥱 - energia',
        'sliderIcon_2': '🔋 + eneriga',
        'doubleonChange': (newValue) {
          setState(() {
            _morningFeeling = newValue;
          });
        },
      },

      // LAYER 6
      // Selecione os fatores que estiveram presentes durante o seu dia e antes de você ir dormir
      {
        'layer': 6,
        'title':
            'Selecione os fatores que estiveram presentes durante o seu dia e antes de você ir dormir',
        'valueList': _techniquesUsedToday,
        'type': InputType.choiceChip,
        'options': const [
          'Técnica Emi-sleep-1',
          'Técnica Emi-sleep-2',
          'Técnica Emi-sleep-3',
          'Técnica Emi-ton',
          'Técnica Emi-ansi-1',
          'Técnica Emi-ansi-2',
        ],
        'onChange': (item) {
          setState(() {
            cardViewModel.toggleFactors(_techniquesUsedToday, item);
          });
        },
      },

      // LAYER 7
      // Selecione os fatores presentes durante o período de sono
      {
        'layer': 7,
        'title': 'Selecione os fatores presentes durante o período de sono',
        'valueList': _positiveFactorsToday,
        'type': InputType.choiceChip,
        'options': const [
          'Técnica Emi-sleep-1',
          'Técnica Emi-sleep-2',
          'Técnica Emi-sleep-3',
          'Técnica Emi-ton',
          'Técnica Emi-ansi-1',
          'Técnica Emi-ansi-2',
        ],
        'onChange': (item) {
          setState(() {
            cardViewModel.toggleFactors(_positiveFactorsToday, item);
          });
        },
      },

      // LAYER 8
      // Selecione os fatores que estiveram presentes antes de dormir:
      {
        'layer': 8,
        'title':
            'Selecione os fatores que estiveram presentes antes de dormir:',
        'valueList': _negativeFactorsToday,
        'type': InputType.choiceChip,
        'options': const [
          'Técnica Emi-sleep-1',
          'Técnica Emi-sleep-2',
          'Técnica Emi-sleep-3',
          'Técnica Emi-ton',
          'Técnica Emi-ansi-1',
          'Técnica Emi-ansi-2',
        ],
        'onChange': (item) {
          setState(() {
            cardViewModel.toggleFactors(_negativeFactorsToday, item);
          });
        },
      },

      // LAYER 9
      // Fatores durante o sono
      {
        'layer': 9,
        'title': 'Fatores durante o sono',
        'valueList': _sleepFactors,
        'options': const [
          'Técnica Emi-sleep-1',
          'Técnica Emi-sleep-2',
          'Técnica Emi-sleep-3',
          'Técnica Emi-ton',
          'Técnica Emi-ansi-1',
          'Técnica Emi-ansi-2',
        ],
        'type': InputType.choiceChip,
        'onChange': (item) {
          setState(() {
            cardViewModel.toggleFactors(_sleepFactors, item);
          });
        },
      },

      // LAYER 10
      // Você fez uso de algum medicamento para dormir/ansiedade?
      {
        'layer': 10,
        'title': 'Você fez uso de algum medicamento para dormir/ansiedade?',
        'boolValue': _medicationUsageYesterday,
        'type': InputType.bool,
        'onPressed': () {
          setState(() {
            _medicationUsageYesterday = true;
          });
        },
        'onPressed2': () {
          setState(() {
            _medicationUsageYesterday = false;
          });
        }
      },

      // Algum comentário a mais?
      {
        'layer': 10,
        'title': 'Algum comentário a mais?',
        'stringValueController': _additionalComments,
        'type': InputType.text,
        'onPressed': () {}
      },

      // LAYER 11
      // O quanto você se dedicou ao programa Sonoflow hoje
      {
        'layer': 11,
        'title': 'O quanto você se dedicou ao programa Sonoflow hoje',
        'doubleValue': _sleepFlowDedication,
        'type': InputType.slider,
        'sliderIcon_1': '😊 - estresse',
        'sliderIcon_2': '😡 + estresse',
        'doubleonChange': (newValue) {
          setState(() {
            _sleepFlowDedication = newValue;
          });
        },
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Fundo de tela com uma imagem e cor de fundo
          color: Color.fromRGBO(12, 31, 61, 1),
          image: DecorationImage(
            image: AssetImage('assets/auth_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildAppBar(context, layerViewModel),
            if (layerViewModel.layer == 0) ...[
              const SizedBox(height: 20),
              _buildWelcomeLayer(context, layerViewModel)
            ] else
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...cards
                              .where((card) =>
                                  card['layer'] == layerViewModel.layer)
                              .map((card) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 32.0),
                              child: DiaryCardWidget(
                                title: card['title'] ?? '',
                                value: card['value'] ?? '',
                                type: card['type'],
                                boolValue: card['boolValue'] ?? false,
                                stringValueController:
                                    card['stringValueController'],

                                // Propriedades relacionadas ao valor
                                doubleValue: card['doubleValue'] as double?,
                                doubleonChange:
                                    card['doubleonChange'] as Function(double)?,

                                // Propriedades relacionadas à seleção
                                options:
                                    List<String>.from(card['options'] ?? []),
                                valueList: card['valueList'] ?? [],

                                // Propriedades de interação
                                onPressed: card['onPressed'] as Function()?,
                                onPressed2: card['onPressed2'] as Function()?,
                                onChange: card['onChange'] as Function(String)?,

                                // Ícones do slider
                                sliderIcon_1: card['sliderIcon_1'],
                                sliderIcon_2: card['sliderIcon_2'],
                              ),
                            );
                          }),
                        ],
                      )),
                      const SliderWidget(),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  /// APP BAR
  ///
  /// Constrói a AppBar personalizada para a tela do diário.
  /// - Exibe um botão de voltar, que retorna à camada anterior ou sai da tela.
  /// - Exibe o título da camada atual baseado no `layerViewModel`.
  Widget _buildAppBar(
      BuildContext context, ChangeLayerViewmodel layerViewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 55),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Botão de voltar (altera a camada ou fecha a tela)
            GestureDetector(
              onTap: () {
                setState(() {
                  if (layerViewModel.layer > layerViewModel.minLayer) {
                    layerViewModel.previousLayer();
                  } else {
                    Navigator.pop(context);
                  }
                });
              },
              child: const Image(
                image: AssetImage("assets/icons/arrow_left.png"),
              ),
            ),
            const SizedBox(width: 20),
            // Exibe o título da camada atual
            Text(
              layerViewModel.layerTitle,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }

  /// WELCOME LAYER
  ///
  /// Constrói a camada de boas-vindas (primeira camada) do diário.
  /// - Exibe uma mensagem encorajando o usuário a iniciar o diário do sono.
  /// - Exibe um botão que, ao ser pressionado, avança para a próxima camada.
  Widget _buildWelcomeLayer(
      BuildContext context, ChangeLayerViewmodel layerViewModel) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          // Bordas arredondadas no topo
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          color: AppColors.ghostWhite,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CARD
                // Exibe uma mensagem e uma imagem no centro da tela
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        const Text(
                          "Realize o seu diário do sono para que possamos te ajudar a melhorar sua qualidade do sono",
                          style: TextStyle(
                            color: AppColors.midnightBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // Imagem central no card
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: AppColors.linearBlueGradient,
                          ),
                          padding: const EdgeInsets.all(16),
                          child: const Image(
                            image: AssetImage(
                                "assets/public/img_sleep_diary_man_2_vector.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // BUTTON
                // Botão para iniciar o questionário
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            layerViewModel.nextLayer();
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(AppColors.goldenYellow),
                          minimumSize:
                              WidgetStateProperty.all(const Size(0, 80)),
                        ),
                        child: const Text(
                          "Iniciar questionário",
                          style: TextStyle(
                            color: AppColors.midnightBlue,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectSleepDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(3000),
    );
    if (selectedDate != null) {
      setState(() {
        String newValue = selectedDate.toString().split(" ")[0];
        _sleepDate = newValue;
      });
    }
  }

  void _selectTime(BuildContext context, ValueNotifier<String> time) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        String newTime = selectedTime.format(context);
        time.value = newTime;
      });
    }
  }
}
