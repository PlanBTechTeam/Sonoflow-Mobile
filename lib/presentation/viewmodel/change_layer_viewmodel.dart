import 'package:flutter/material.dart';

class ChangeLayerViewmodel extends ChangeNotifier {
  int _layer = 0; // Camada inicial
  String _layerTitle = "Diário do sono";

  // Constantes para os limites das camadas
  int minLayer = 0;
  int maxLayer = 11;

  // Getter para acessar o valor atual da camada
  int get layer => _layer;

  // Getter para acessar o título da camada
  String get layerTitle => _layerTitle;

  // Avança para a próxima camada, se não atingir o limite máximo
  void nextLayer() {
    if (_layer < maxLayer) _layer++;
    _updateLayerTitle();
    notifyListeners();
  }

  // Retorna para a camada anterior, se não atingir o limite mínimo
  void previousLayer() {
    if (_layer > minLayer) _layer--;
    _updateLayerTitle();
    notifyListeners();
  }

  // Função privada para atualizar o título com base na camada atual
  void _updateLayerTitle() {
    switch (_layer) {
      case 0:
        _layerTitle = "Diário do sono";
      case 1:
        _layerTitle = "Rotina do sono";
      case 2:
        _layerTitle = 'Rotina do sono';
      case 3:
        _layerTitle = 'Qualidade do sono';
      case 4:
        _layerTitle = 'Qualidade do sono';
      case 5:
        _layerTitle = 'Aceleradores';
      case 6:
        _layerTitle = 'Aceleradores';
      case 7:
        _layerTitle = 'Aceleradores';
      case 8:
        _layerTitle = 'Aceleradores';
      case 9:
        _layerTitle = 'Comentarios';
    }
  }
}
