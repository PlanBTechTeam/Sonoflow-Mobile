import 'package:flutter/material.dart';

/// APP COLORS
///
/// Esta classe contém todas as cores personalizadas usadas no aplicativo.
class AppColors {
  static const Color mediumGray = Color.fromRGBO(161, 161, 161, 1);
  static const Color midnightBlue = Color.fromRGBO(15, 27, 64, 1);
  static const Color goldenYellow = Color.fromRGBO(196, 162, 90, 1);
  static const Color ghostWhite = Color.fromRGBO(245, 245, 253, 1);
  static const Color steelBlue = Color.fromRGBO(94, 105, 128, 0.2);
  static const Color whiteSmoke = Color.fromRGBO(255, 255, 255, 0.1);
  static const LinearGradient linearBlueGradient = LinearGradient(
    colors: [
      Color.fromRGBO(16, 28, 66, 1),
      Color.fromRGBO(33, 58, 89, 1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const Color softSkyBlueGradient = Color.fromRGBO(188, 231, 255, 0.51);
}
