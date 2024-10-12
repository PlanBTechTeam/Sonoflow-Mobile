import 'package:flutter/material.dart';
import 'package:sonoflow/presentation/utils/auth_mode.dart';


/* ===== TOGGLE AUTH BUTTON=====
* */
class ToggleAuthButton extends StatelessWidget {
  final AuthMode state;
  final VoidCallback onToggle;

  const ToggleAuthButton(
      {super.key, required this.state, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.15),
          borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ===== ENTRAR =====
            Expanded(
                child: GestureDetector(
              onTap: () {
                if (state != AuthMode.LOGIN) {
                  onToggle();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: state == AuthMode.LOGIN
                        ? const Color.fromRGBO(94, 105, 128, 0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular((32))),
                alignment: Alignment.center,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )),
            // ===== REGISTRAR =====
            Expanded(
                child: GestureDetector(
              onTap: () {
                if (state != AuthMode.REGISTER) {
                  onToggle();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: state == AuthMode.REGISTER
                        ? const Color.fromRGBO(94, 105, 128, 0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular((32))),
                alignment: Alignment.center,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Registrar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
