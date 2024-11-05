import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sonoflow/models/user_model.dart';

// TODO: docs
class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // TODO: docs
  bool isUserLoggedIn() => _auth.currentUser != null;

  // TODO: docs
  Future<User?> registerWithUserInformation({
    required String username,
    required String email,
    required String password,
    Uint8List? picture,
    int? sleepGoal,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var userCredential = credential.user;

      // TODO: salvar imagem

      UserModel user = UserModel(
        uid: userCredential!.uid,
        username: username,
        email: userCredential.email!,
        registrationDate: DateTime.now(),
        sleepGoal: sleepGoal,
        // TODO: profilePictureUrl
      );

      // TODO: salvar user no banco

      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // TODO: docs
  Future<User?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
