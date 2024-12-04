import 'package:flutter/material.dart';
import 'package:sonoflow/presentation/utils/auth_mode.dart';
import 'package:sonoflow/presentation/view/components/auth_input.dart';
import 'package:sonoflow/presentation/view/components/login_button.dart';
import 'package:sonoflow/presentation/view/components/photo_input.dart';
import 'package:sonoflow/presentation/view/components/toggle_auth_button.dart';

/* ===== AUTH CARD =====
 * Widget principal para exibir o cartão de autenticação.
 * Inclui formulários de entrada para modos de Login e Registro,
 * alternando entre camadas diferentes no Registro.
 */
class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  AuthMode _authMode = AuthMode.LOGIN;
  int _registerLayer = 1; // Variável para controlar a camada de registro
  final int _maxRegisterLauer = 2;

  // ===== BUTTON TO CHANGE AUTH MODE STATE =====
  // Função que alterna entre os modos Login e Registro.
  void _toggleAuthMode() {
    setState(() {
      _authMode =
          _authMode == AuthMode.LOGIN ? AuthMode.REGISTER : AuthMode.LOGIN;
    });
  }

  // ===== CONTROLLERS =====
  // Controladores de texto para manipular dados dos campos de Login e Registro.
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final registerEmailController = TextEditingController();
  final confirmRegisterEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final confirmRegisterPasswordController = TextEditingController();
  final usernameController = TextEditingController();

  // ==================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(94, 105, 128, 0.2),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
              color: const Color.fromRGBO(255, 255, 255, 0.4), width: 2)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 32, bottom: 32, left: 16, right: 16),
        child: Column(
          children: [
            // ========== TOGGLE AUTH BUTTON ==========
            // Exibe o botão para alternar entre Login e Registro na camada inicial.
            if (_authMode == AuthMode.LOGIN ||
                _authMode == AuthMode.REGISTER && _registerLayer == 1) ...[
              ToggleAuthButton(
                state: _authMode,
                onToggle: _toggleAuthMode,
              )
            ],

            // Botão para navegação entre camadas de Registro (se não estiver na camada 1).
            if (_authMode == AuthMode.REGISTER && _registerLayer != 1) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _registerLayer = _registerLayer - 1;
                          });
                        },
                        child: const Icon(
                          Icons.arrow_left,
                          color: Colors.white,
                          size: 25,
                        )),
                    const Text(
                      'Últimas informações',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    Text('$_registerLayer/3',
                        style: const TextStyle(color: Colors.white))
                  ],
                ),
              )
            ],

            // ===== SPACE =====
            const SizedBox(height: 16),

            // ========== LOGIN MODE ==========
            // Campos de entrada e botão de login.
            if (_authMode == AuthMode.LOGIN) ...[
              InputAuth(
                controller: loginEmailController,
                hintText: 'E-mail',
                icon: Icons.email,
              ),
              const SizedBox(height: 16),
              InputAuth(
                controller: loginPasswordController,
                hintText: 'Senha',
                password: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(
                    child: LoginButton(text: "Entrar"),
                  ),
                ],
              )
            ],

            // ========== REGISTER MODE ==========
            // Campos de entrada e botão de registro, organizados em camadas.
            if (_authMode == AuthMode.REGISTER) ...[
              if (_registerLayer == 1) ...[
                InputAuth(
                  controller: registerEmailController,
                  hintText: 'E-mail',
                  icon: Icons.email,
                ),
                const SizedBox(height: 16),
                InputAuth(
                  controller: confirmRegisterEmailController,
                  hintText: 'Confirme seu E-mail',
                  icon: Icons.email,
                ),
                const SizedBox(height: 16),
              ],
              if (_registerLayer == 2) ...[
                InputAuth(
                  controller: registerPasswordController,
                  hintText: 'Senha',
                  password: true,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 16),
                InputAuth(
                  controller: confirmRegisterPasswordController,
                  hintText: 'Confirme sua Senha',
                  password: true,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 16),
              ],
              if (_registerLayer == 3) ...[
                ImagePickerWidget(),
                InputAuth(
                  controller: usernameController,
                  hintText: 'Nome',
                  icon: Icons.person,
                ),
                const SizedBox(height: 16),
              ],

              // Botão de continuar ou registrar, dependendo da camada.
              Row(
                children: [
                  Expanded(
                    child: _registerLayer == 1 || _registerLayer == 2
                        ? LoginButton(
                            text: "CONTINUAR",
                            onPressed: () {
                              _updateRegisterLayer();
                            },
                          )
                        : LoginButton(
                            text: "REGISTRAR",
                            onPressed: () {
                              _updateRegisterLayer();
                            },
                          ),
                  ),
                  Text(_registerLayer.toString())
                ],
              )
            ],
          ],
        ),
      ),
    );
  }

  void _updateRegisterLayer() {
    setState(() {
      if (_registerLayer < _maxRegisterLauer) {
        _registerLayer = _registerLayer + 1;
      }
    });
  }
}
