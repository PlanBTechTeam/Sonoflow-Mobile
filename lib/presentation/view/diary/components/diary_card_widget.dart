import 'package:flutter/material.dart';
import 'package:sonoflow/models/input_type.dart';
import 'package:sonoflow/presentation/utils/colors.dart';


/// Widget que representa um cartão no diário, exibindo um título e um
/// valor associados a diferentes tipos de entrada. Este componente é
/// configurável e pode lidar com diferentes tipos de dados de entrada,
/// como texto, booleano, seleção e outros.
///
/// ### Parâmetros:
/// - `title`: Título exibido no cartão. Deve ser fornecido como uma
///   string obrigatória.
/// - `value`: Valor exibido no cartão. Deve ser fornecido como uma
///   string obrigatória.
/// - `boolValue`: Valor booleano opcional associado ao cartão.
/// - `type`: O tipo de entrada (definido em `InputType`) que determina
///   como o valor será exibido ou manipulado. Este parâmetro é
///   obrigatório.
/// - `doubleValue`: Valor opcional do tipo double.
/// - `options`: Lista de opções para entradas do tipo seleção (opcional).
/// - `valueList`: Lista de valores associados ao cartão (opcional).
/// - `stringValueController`: Controlador de texto opcional para entradas
///   de texto.
/// - `sliderIcon_1`: Ícone opcional para o primeiro extremo do slider.
/// - `sliderIcon_2`: Ícone opcional para o segundo extremo do slider.
/// - `onPressed`: Função opcional a ser chamada quando um botão é
///   pressionado.
/// - `onPressed2`: Função opcional a ser chamada quando um segundo botão
///   é pressionado.
/// - `onChange`: Função opcional que é chamada quando o valor de entrada
///   é alterado (para entrada de texto).
/// - `doubleonChange`: Função opcional que é chamada quando o valor
///   do slider é alterado.
///
/// O widget é expandido para ocupar o espaço disponível na interface do
/// usuário, com um fundo estilizado e uma apresentação visual centrada.
class DiaryCardWidget extends StatefulWidget {
  final String title;
  final String value;
  final bool? boolValue;
  final InputType type;
  final double? doubleValue;
  final List<String>? options;
  final List? valueList;
  final TextEditingController? stringValueController;
  final String? sliderIcon_1;
  final String? sliderIcon_2;
  final Function()? onPressed;
  final Function()? onPressed2;
  final Function(String)? onChange;
  final Function(double)? doubleonChange;

  const DiaryCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.type,
    this.boolValue,
    this.doubleValue,
    this.options,
    this.valueList,
    this.stringValueController,
    this.sliderIcon_1,
    this.sliderIcon_2,
    this.onPressed,
    this.onPressed2,
    this.onChange,
    this.doubleonChange,
  });

  @override
  State<DiaryCardWidget> createState() => _DiaryCardWidgetState();
}

class _DiaryCardWidgetState extends State<DiaryCardWidget> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.steelBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(),
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildInput(),
            ],
          ),
        ),
      ),
    );
  }

  /// Método privado que constrói o widget de entrada com base no tipo de entrada especificado
  /// no componente. Cada tipo de entrada é representado por um caso dentro da estrutura de
  /// controle `switch`, que define a exibição e o comportamento do widget.
  ///
  /// - `InputType.date`: Cria um botão para selecionar datas, exibindo o valor de data atual
  ///   e chamando a função `onPressed` ao ser pressionado.
  /// - `InputType.time`: Exibe um botão para selecionar horas, semelhante ao botão de data,
  ///   chamando `onPressed`.
  /// - `InputType.text`: Exibe um campo de texto (`TextField`) para entrada de texto livre,
  ///   com uma dica para o usuário (`hint`).
  /// - `InputType.select`: Exibe um botão com um `DropdownButton` para seleção de opções,
  ///   que chama `onChange` ao selecionar um item.
  /// - `InputType.count`: Exibe um contador com botões de incremento e decremento,
  ///   chamando `onPressed` e `onPressed2` para diminuir e aumentar o valor respectivamente.
  /// - `InputType.slider`: Exibe um controle deslizante (`Slider`) para entrada de valores
  ///   numéricos contínuos, mostrando os valores nas extremidades e chamando `doubleonChange`
  ///   ao ser alterado.
  /// - `InputType.choiceChip`: Exibe uma série de `ChoiceChip` para seleção de múltiplos valores,
  ///   permitindo ao usuário selecionar múltiplos itens e chamando `onChange` para cada seleção.
  /// - `InputType.bool`: Exibe duas opções de botão ('Sim' e 'Não') para seleção de valor
  ///   booleano, alterando a cor do botão com base no valor de `boolValue`.
  ///
  /// Retorna o widget de entrada correspondente ao tipo especificado.
  Widget _buildInput() {
    switch (widget.type) {
      case InputType.date:
        return ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.whiteSmoke),
          onPressed: widget.onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(child: _buildInputIcon()),
                if (widget.type == InputType.date ||
                    widget.type == InputType.time) ...[
                  Expanded(
                    child: Text(
                      widget.value,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                if (widget.type == InputType.select) ...[
                  Expanded(
                    child: Center(
                      child: DropdownButton<String>(
                        value: _selectedValue,
                        icon: const Icon(null),
                        dropdownColor: Colors.grey,
                        items: widget.options?.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Container(
                              width: 190,
                              alignment: Alignment.center,
                              child: Text(
                                item,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedValue = newValue!;
                          });
                          widget.onChange?.call(newValue ?? '');
                        },
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      case InputType.time:
        return ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.whiteSmoke),
          onPressed: widget.onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(child: _buildInputIcon()),
                Expanded(
                  child: Text(
                    widget.value,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      case InputType.text:
        return TextField(
          controller: widget.stringValueController,
          style: const TextStyle(color: Colors.white),
          // Cor do texto do TextField
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Digite aqui',
            hintStyle:
                TextStyle(color: Colors.grey[400]), // Cor do texto de dica
          ),
        );
      case InputType.select:
        return ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.whiteSmoke),
          onPressed: widget.onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(child: _buildInputIcon()),
                Expanded(
                  child: Center(
                    child: DropdownButton<String>(
                      value: _selectedValue,
                      icon: const Icon(null),
                      dropdownColor: Colors.grey,
                      items: widget.options?.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Container(
                            width: 190,
                            alignment: Alignment.center,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedValue = newValue!;
                        });
                        widget.onChange?.call(newValue ?? '');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case InputType.count:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: RawMaterialButton(
                onPressed: widget.onPressed,
                elevation: 2.0,
                fillColor: AppColors.whiteSmoke,
                shape: const CircleBorder(),
                child: const Text(
                  '-',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            Container(
              width: 75,
              height: 45,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.1),
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                  child: Text(
                widget.value,
                style: const TextStyle(color: Colors.white),
              )),
            ),
            SizedBox(
              width: 45,
              height: 45,
              child: RawMaterialButton(
                onPressed: widget.onPressed2,
                elevation: 2.0,
                fillColor: AppColors.whiteSmoke,
                shape: const CircleBorder(),
                child: const Text(
                  '+',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      case InputType.slider:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.sliderIcon_1!.substring(0, 2),
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.sliderIcon_1!.substring(2),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.doubleValue?.toStringAsFixed(1)}%" ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.sliderIcon_2!.substring(2),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.sliderIcon_2!.substring(0, 2),
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Use Expanded here
            SizedBox(
              height: 30,
              child: Slider(
                value: widget.doubleValue ?? 0,
                // Use 0 como padrão se doubleValue for nulo
                max: 100,
                onChanged: (value) {
                  setState(() {
                    widget.doubleonChange!(value);
                  });
                },
                activeColor: const Color.fromRGBO(201, 169, 107, 1),
              ),
            ),
          ],
        );
      case InputType.choiceChip:
        return Wrap(
          spacing: 8.0,
          children: List<Widget>.generate(
            widget.options!.length,
            (index) {
              final item = widget.options![index];
              return ChoiceChip(
                label: Text(item),
                selected: widget.valueList!.contains(item),
                onSelected: (selected) {
                  // Chamar uma função para gerenciar a mudança
                  if (widget.onChange != null) {
                    widget.onChange!(
                        item); // Chama a função onChange se não for nula
                  }
                },
              );
            },
          ),
        );
      case InputType.bool:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RawMaterialButton(
                  onPressed: widget.onPressed,
                  elevation: 2.0,
                  fillColor: widget.boolValue == true
                      ? Colors.green
                      : AppColors.whiteSmoke,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: const Text(
                    'Sim',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RawMaterialButton(
                  onPressed: widget.onPressed2,
                  elevation: 2.0,
                  fillColor: widget.boolValue == false
                      ? Colors.red
                      : AppColors.whiteSmoke,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: const Text(
                    'Não',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );

      default:
        return Container();
    }
  }

  /// Método privado que constrói o ícone de entrada com base no tipo de entrada
  /// especificado para o componente. Cada tipo de entrada mapeia para um ícone
  /// específico, retornando o widget de imagem correspondente.
  ///
  /// - `InputType.date`: Exibe o ícone de calendário localizado em
  ///   `"assets/icons/diary/calendar_icon.png"`.
  /// - `InputType.time`: Exibe o ícone de agenda localizado em
  ///   `"assets/icons/diary/schedule_icon.png"`.
  /// - `InputType.text`: (não implementado atualmente; o caso precisa ser tratado).
  /// - `InputType.select`: Reutiliza o ícone de agenda localizado em
  ///   `"assets/icons/diary/schedule_icon.png"`.
  /// - `InputType.count`: Não exibe ícone, retornando `null`.
  /// - `InputType.slider`: Não possui um ícone associado (caso não tratado).
  /// - `InputType.choiceChip`: Não possui um ícone associado (caso não tratado).
  /// - `InputType.bool`: Não possui um ícone associado (caso não tratado).
  ///
  /// - `default`: Retorna um container vazio (`Container`) para qualquer tipo não especificado.
  ///
  /// Retorna um widget de imagem (`Image`) contendo o ícone correspondente ou
  /// `null`/`Container` quando não aplicável.
  Widget? _buildInputIcon() {
    String assetImage = '';

    switch (widget.type) {
      case InputType.date:
        assetImage = "assets/icons/diary/calendar_icon.png";
        break;
      case InputType.time:
        assetImage = "assets/icons/diary/schedule_icon.png";
        break;
      case InputType.select:
        assetImage = "assets/icons/diary/schedule_icon.png";
        break;
      case InputType.text:
      // TODO: Handle this case.
      case InputType.count:
        return null;
      default:
        return Container();
    }

    return Image(image: AssetImage(assetImage));
  }
}
