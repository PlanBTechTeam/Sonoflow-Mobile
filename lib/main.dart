import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonoflow/firebase_options.dart';
import 'package:sonoflow/presentation/provider/home_provider.dart';
import 'package:sonoflow/presentation/view/auth/auth_screen.dart';
import 'package:sonoflow/presentation/viewmodel/change_layer_viewmodel.dart';
import 'package:sonoflow/presentation/viewmodel/diarycard_viewmodel.dart';
import 'package:sonoflow/services/firebase_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChangeLayerViewmodel()),
        ChangeNotifierProvider(create: (context) => DiaryCardViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final FirebaseAuthService _auth = FirebaseAuthService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (_auth.isUserLoggedIn()) ? const HomeProvider() : const AuthScreen(),
    );
  }
}
