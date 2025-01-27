/// Modelo de Diário do Sono
///
/// Representa os dados relativos ao diário de sono de um usuário.
/// Inclui informações detalhadas sobre o sono, como horários de dormir,
/// número de despertares durante a noite, fatores que afetaram o sono,
/// e a percepção de ansiedade, estresse e cansaço do usuário no dia seguinte.
class DiaryModel {
  final String sleepDate;
  final String bedTime;
  final String sleepAttemptTime;
  final String timeToFallAsleep;
  final int nightAwakenings;
  final String timeToFallAsleepAgain;
  final String lastWakeUpTime;
  final String wakeUpTime;
  final double anxietyComparisonToday;
  final double fatigueReduction;
  final double stressComparisonToday;
  final double morningFeeling;
  final List<String> techniquesUsedToday;
  final List<String> positiveFactorsToday;
  final List<String> negativeFactorsToday;
  final List<String> sleepFactors;
  final bool medicationUsageYesterday;
  final String additionalComments;
  final double sleepFlowDedication;

  /// Constrói um objeto [DiaryModel] com as informações fornecidas.
  ///
  /// [sleepDate]: Data do registro do diário de sono.<br>
  /// [bedTime]: Hora em que o usuário foi para a cama.<br>
  /// [sleepAttemptTime]: Hora em que o usuário tentou dormir.<br>
  /// [timeToFallAsleep]: Tempo que o usuário levou para adormecer.<br>
  /// [nightAwakenings]: Número de vezes que o usuário acordou durante a noite.<br>
  /// [timeToFallAsleepAgain]: Tempo que o usuário levou para adormecer novamente após acordar.<br>
  /// [lastWakeUpTime]: Hora do último despertar durante a noite.<br>
  /// [wakeUpTime]: Hora em que o usuário acordou pela manhã.<br>
  /// [anxietyComparisonToday]: Comparação da ansiedade do usuário no dia em relação ao normal.<br>
  /// [fatigueReduction]: Percepção de redução de cansaço no dia seguinte.<br>
  /// [stressComparisonToday]: Comparação do estresse do usuário no dia em relação ao normal.<br>
  /// [morningFeeling]: Sensação geral do usuário ao acordar.<br>
  /// [techniquesUsedToday]: Técnicas usadas para melhorar o sono ou o bem-estar durante o dia.<br>
  /// [positiveFactorsToday]: Fatores positivos observados no dia.<br>
  /// [negativeFactorsToday]: Fatores negativos observados no dia.<br>
  /// [sleepFactors]: Fatores que impactaram a qualidade do sono.<br>
  /// [medicationUsageYesterday]: Se o usuário fez uso de medicação no dia anterior.<br>
  /// [additionalComments]: Comentários adicionais sobre o sono ou o dia.<br>
  /// [sleepFlowDedication]: Dedicação do usuário ao programa SonoFlow.
  DiaryModel({
    required this.sleepDate,
    required this.bedTime,
    required this.sleepAttemptTime,
    required this.timeToFallAsleep,
    required this.nightAwakenings,
    required this.timeToFallAsleepAgain,
    required this.lastWakeUpTime,
    required this.wakeUpTime,
    required this.anxietyComparisonToday,
    required this.fatigueReduction,
    required this.stressComparisonToday,
    required this.morningFeeling,
    required this.techniquesUsedToday,
    required this.positiveFactorsToday,
    required this.negativeFactorsToday,
    required this.sleepFactors,
    required this.medicationUsageYesterday,
    required this.additionalComments,
    required this.sleepFlowDedication,
  });

  /// Converte um objeto [DiaryModel] para um mapa.
  ///
  /// Retorna um mapa com chave-valor representando os dados do diário de sono.
  Map<String, dynamic> toMap() {
    return {
      'sleepDate': sleepDate,
      'bedTime': bedTime,
      'sleepAttemptTime': sleepAttemptTime,
      'wakeUpTime': wakeUpTime,
      'lastWakeUpTime': lastWakeUpTime,
      'timeToFallAsleep': timeToFallAsleep,
      'timeToFallAsleepAgain': timeToFallAsleepAgain,
      'nightAwakenings': nightAwakenings,
      'techniquesUsedToday': techniquesUsedToday,
      'positiveFactorsToday': positiveFactorsToday,
      'negativeFactorsToday': negativeFactorsToday,
      'sleepFactors': sleepFactors,
      'anxietyComparisonToday': anxietyComparisonToday,
      'fatigueReduction': fatigueReduction,
      'stressComparisonToday': stressComparisonToday,
      'morningFeeling': morningFeeling,
      'medicationUsageYesterday': medicationUsageYesterday,
      'additionalComments': additionalComments,
      'sleepFlowDedication': sleepFlowDedication,
    };
  }

  /// Cria um objeto [DiaryModel] a partir de um mapa.
  ///
  /// [map]: Mapa contendo as chaves e valores correspondentes aos dados de um diário de sono.
  ///
  /// Retorna um objeto [DiaryModel] populado com os dados do mapa.
  static DiaryModel fromMap(Map<String, dynamic> map) => DiaryModel(
        sleepDate: map['sleepDate'],
        bedTime: map['bedTime'],
        sleepAttemptTime: map['sleepAttemptTime'],
        wakeUpTime: map['wakeUpTime'],
        lastWakeUpTime: map['lastWakeUpTime'],
        timeToFallAsleep: map['timeToFallAsleep'],
        timeToFallAsleepAgain: map['timeToFallAsleepAgain'],
        nightAwakenings: map['nightAwakenings'],
        techniquesUsedToday: map['techniquesUsedToday'],
        positiveFactorsToday: map['positiveFactorsToday'],
        negativeFactorsToday: map['negativeFactorsToday'],
        sleepFactors: map['sleepFactors'],
        anxietyComparisonToday: map['anxietyComparisonToday'],
        fatigueReduction: map['fatigueReduction'],
        stressComparisonToday: map['stressComparisonToday'],
        morningFeeling: map['morningFeeling'],
        medicationUsageYesterday: map['medicationUsageYesterday'],
        additionalComments: map['additionalComments'],
        sleepFlowDedication: map['sleepFlowDedication'],
      );
}
