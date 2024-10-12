import 'package:flutter/material.dart';
import 'package:sonoflow/presentation/utils/auth_mode.dart';
import 'package:sonoflow/presentation/view/components/auth_input.dart';
import 'package:sonoflow/presentation/view/components/photo_input.dart';
import 'package:sonoflow/presentation/view/components/toggle_auth_button.dart';


/* ===== AUTH CARD =====
* */
class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  AuthMode _authMode = AuthMode.LOGIN;
  int _registerLayer = 1;

  // ===== BUTTON TO CHANGE AUTH MODE STATE =====
  void _toggleAuthMode() {
    setState(() {
      _authMode =
          _authMode == AuthMode.LOGIN ? AuthMode.REGISTER : AuthMode.LOGIN;
    });
  }

  // ===== CONTROLLERS =====
  // == LOGIN ==
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // == REGISTER
  final registerEmailController = TextEditingController();
  final confirmRegisterEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final confirmRegisterPasswordController = TextEditingController();

  // == USERNAME ==
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // ========== TOGGLE AUTH BUTTON ==========
            // == SE FOR LOGIN OU REGISTER E LAYER = 1 ==
            if (_authMode == AuthMode.LOGIN ||
                _authMode == AuthMode.REGISTER && _registerLayer == 1) ...[
              ToggleAuthButton(
                state: _authMode,
                onToggle: _toggleAuthMode,
              )
            ],

            // == TOGGLE AUTH BUTTON (SE FOR REGISTER E LAYER != 1) ==
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

            // ========== LOGIN MODE ==========1
            if (_authMode == AuthMode.LOGIN) ...[
              // == INPUT AUTH (EMAIL) ==
              InputAuth(
                controller: loginEmailController,
                hintText: 'E-mail',
                icon: Icons.email,
              ),
              const SizedBox(height: 16),

              // == INPUT AUTH (PASSWORD)==
              InputAuth(
                controller: loginPasswordController,
                hintText: 'Senha',
                password: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 16),

              // ===== LOGIN BUTTON=====
              ElevatedButton(onPressed: () {}, child: const Text('LOGIN'))
            ],

            // ========== REGISTER MODE ==========
            if (_authMode == AuthMode.REGISTER) ...[
              if (_registerLayer == 1) ...[
                // == INPUT AUTH (EMAIL) ==
                InputAuth(
                  controller: registerEmailController,
                  hintText: 'E-mail',
                  icon: Icons.email,
                ),
                const SizedBox(height: 16),

                // == INPUT AUTH (CONFIRM EMAIL) ==
                InputAuth(
                  controller: confirmRegisterEmailController,
                  hintText: 'Confirme seu E-mail',
                  icon: Icons.email,
                ),
                const SizedBox(height: 16),
              ],
              if (_registerLayer == 2) ...[
                // == INPUT AUTH (PASSWORD)==
                InputAuth(
                  controller: registerPasswordController,
                  hintText: 'Senha',
                  password: true,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 16),

                // == INPUT AUTH (CONFIRM PASSWORD) ==
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
                // == INPUT AUTH (FIRST NAME)==
                InputAuth(
                  controller: usernameController,
                  hintText: 'Nome',
                  icon: Icons.person,
                ),
                const SizedBox(height: 16),
              ],

              // ===== REGISTER BUTTON=====
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _registerLayer = _registerLayer + 1;
                    });
                  },
                  child: Text(_registerLayer == 1 || _registerLayer == 2
                      ? 'CONTINUAR'
                      : 'REGISTRAR'))
            ],
          ],
        ),
      ),
    );
  }
}
