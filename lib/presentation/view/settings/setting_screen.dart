import 'package:flutter/material.dart';
import 'package:sonoflow/presentation/utils/colors.dart';
import 'package:sonoflow/presentation/view/auth/auth_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(32), topLeft: Radius.circular(32)),
            color: Colors.white,
          ),
          child:  Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [

                const Center(
                  child: Text('SETTING SCREEN'),
                ),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
                }, child: const Text('SAIR'))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
