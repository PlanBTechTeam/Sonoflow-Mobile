import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sonoflow/models/user_model.dart';
import 'package:sonoflow/services/firebase_storage_service.dart';
import 'package:sonoflow/services/firestore_service.dart';

/// Serviço de autenticação Firebase.
///
/// Oferece métodos para autenticação de usuários utilizando o Firebase Authentication.
class FirebaseAuthService {
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseStorageService _storage = FirebaseStorageService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Verifica se o usuário está autenticado.
  ///
  /// Retorna `true` se o usuário estiver logado, caso contrário, retorna `false`.
  bool isUserLoggedIn() => _auth.currentUser != null;

  /// Registra um novo usuário com as informações fornecidas.
  ///
  /// [username]: Nome de usuário a ser associado à conta.<br>
  /// [email]: Endereço de e-mail do usuário.<br>
  /// [password]: Senha para a nova conta.<br>
  /// [picture]: (Opcional) Imagem de perfil do usuário em formato `Uint8List`.<br>
  /// [sleepGoal]: (Opcional) Meta de horas de sono do usuário.<br>
  ///
  /// Retorna o objeto `User` do Firebase, representando o usuário criado,
  /// ou `null` em caso de falha.
  ///
  /// Exceções:
  /// - Pode lançar uma `FirebaseAuthException` em caso de erro durante o registro.
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
      String? pictureUrl = picture != null
          ? await _storage.uploadUserProfilePicture(
              "${userCredential!.uid}-photoURL.png", picture)
          // TODO: placeholder image if null
          : null;

      UserModel user = UserModel(
        uid: userCredential!.uid,
        username: username,
        email: userCredential.email!,
        registrationDate: userCredential.metadata.creationTime!,
        sleepGoal: sleepGoal,
        photoUrl: pictureUrl,
      );

      _firestoreService.registerUser(user);

      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  /// Autentica um usuário usando e-mail e senha.
  ///
  /// [email]: Endereço de e-mail do usuário.<br>
  /// [password]: Senha do usuário.<br>
  ///
  /// Retorna o objeto `User` do Firebase, que representa o usuário autenticado,
  /// ou `null` em caso de falha.
  ///
  /// Exceções:
  /// - Pode lançar uma `FirebaseAuthException` em caso de erro durante o login.
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
