import 'package:flutter/material.dart';
import 'package:sonoflow/presentation/provider/auth_provider.dart';
import 'package:sonoflow/presentation/view/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthProvider(),
    );
  }
}
