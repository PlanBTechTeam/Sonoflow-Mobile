import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sonoflow/models/diary_model.dart';
import 'package:sonoflow/services/firebase_auth_service.dart';
import 'package:sonoflow/services/firestore_service.dart';

/// ViewModel para gerenciamento do estado e lógica do Diário do Sono.
class DiaryCardViewModel extends ChangeNotifier {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirestoreService _firestore = FirestoreService();

  /// Alterna a presença de um item em uma lista de fatores.
  ///
  /// [factors]: A lista de fatores a ser modificada. <br>
  /// [item]: O item a ser adicionado ou removido da lista.
  void toggleFactors(List<String> factors, String item) {
    if (factors.contains(item)) {
      factors.remove(item);
    } else {
      factors.add(item);
    }
    notifyListeners();
  }

  /// Salva uma entrada de Diário do Sono para o usuário autenticado.
  ///
  /// [sleepDate]: Data do sono.<br>
  /// [bedTime]: Horário em que o usuário foi para a cama.<br>
  /// [sleepAttemptTime]: Horário em que o usuário tentou dormir.<br>
  /// [timeToFallAsleep]: Tempo para adormecer.<br>
  /// [nightAwakenings]: Número de despertares noturnos.<br>
  /// [timeToFallAsleepAgain]: Tempo para voltar a dormir após despertar.<br>
  /// [lastWakeUpTime]: Último horário de despertar.<br>
  /// [wakeUpTime]: Horário de acordar.<br>
  /// [anxietyComparisonToday]: Comparação da ansiedade em relação a hoje.<br>
  /// [fatigueReduction]: Redução da fadiga em relação a ontem.<br>
  /// [stressComparisonToday]: Comparação do estresse em relação a hoje.<br>
  /// [morningFeeling]: Sensação ao acordar.<br>
  /// [techniquesUsedToday]: Técnicas usadas no dia.<br>
  /// [positiveFactorsToday]: Fatores positivos do dia.<br>
  /// [negativeFactorsToday]: Fatores negativos do dia.<br>
  /// [sleepFactors]: Fatores presentes no sono.<br>
  /// [medicationUsageYesterday]: Indica se houve uso de medicação no dia anterior.<br>
  /// [additionalComments]: Comentários adicionais.<br>
  /// [sleepFlowDedication]: Dedicação ao SonoFlow.<br>
  ///
  /// Lança exceções caso o usuário não esteja autenticado ou ocorra erro ao salvar no Firestore.
  Future<void> saveDiary({
    required String sleepDate,
    required String bedTime,
    required String sleepAttemptTime,
    required String timeToFallAsleep,
    required int nightAwakenings,
    required String timeToFallAsleepAgain,
    required String lastWakeUpTime,
    required String wakeUpTime,
    required double anxietyComparisonToday,
    required double fatigueReduction,
    required double stressComparisonToday,
    required double morningFeeling,
    required List<String> techniquesUsedToday,
    required List<String> positiveFactorsToday,
    required List<String> negativeFactorsToday,
    required List<String> sleepFactors,
    required bool medicationUsageYesterday,
    required String additionalComments,
    required double sleepFlowDedication,
  }) async {
    User user;

    try {
      user = _auth.getUser()!;
    } catch (e) {
      rethrow;
    }

    DiaryModel diary = DiaryModel(
      sleepDate: sleepDate,
      bedTime: bedTime,
      sleepAttemptTime: sleepAttemptTime,
      timeToFallAsleep: timeToFallAsleep,
      nightAwakenings: nightAwakenings,
      timeToFallAsleepAgain: timeToFallAsleepAgain,
      lastWakeUpTime: lastWakeUpTime,
      wakeUpTime: wakeUpTime,
      anxietyComparisonToday: anxietyComparisonToday,
      fatigueReduction: fatigueReduction,
      stressComparisonToday: stressComparisonToday,
      morningFeeling: morningFeeling,
      techniquesUsedToday: techniquesUsedToday,
      positiveFactorsToday: positiveFactorsToday,
      negativeFactorsToday: negativeFactorsToday,
      sleepFactors: sleepFactors,
      medicationUsageYesterday: medicationUsageYesterday,
      additionalComments: additionalComments,
      sleepFlowDedication: sleepFlowDedication,
    );

    try {
      await _firestore.saveDiary(user, diary);
    } catch (e) {
      rethrow;
    }
  }
}
