import 'package:flutter/material.dart';
import 'package:sonoflow/presentation/view/auth/auth_screen.dart';
import 'package:sonoflow/presentation/view/components/info_toast.dart';
import 'package:sonoflow/services/firebase_auth_service.dart';

class SettingScreen extends StatelessWidget {
  final FirebaseAuthService _auth = FirebaseAuthService();

  SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                const Center(
                  child: Text('SETTING SCREEN'),
                ),
                ElevatedButton(
                  onPressed: () => _signOut(context),
                  child: const Text('SAIR'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _signOut(BuildContext context) async {
    _auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
    InfoToast.show(context, 'Sessão encerrada com sucesso.', Colors.green);
  }
}
