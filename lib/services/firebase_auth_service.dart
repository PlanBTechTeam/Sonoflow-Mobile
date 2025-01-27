import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
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
  bool isUserLoggedIn() => getUser() != null;

  /// Obtém o usuário autenticado.
  ///
  /// Retorna o objeto [User] atualmente autenticado pelo Firebase.
  /// Caso nenhum usuário esteja autenticado, retorna `null`.
  User? getUser() => _auth.currentUser;

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

      picture ??=
          await rootBundle.load('assets/public/missing_profile_picture.jpg').then((data) => data.buffer.asUint8List());

      String? pictureUrl = await _storage.uploadUserProfilePicture(
        "${userCredential!.uid}-photoURL.png",
        picture!,
      );

      UserModel user = UserModel(
        uid: userCredential.uid,
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

  /// Encerra a sessão do usuário autenticado.
  ///
  /// Se o usuário estiver autenticado, ele será desconectado do Firebase Authentication.
  /// Caso contrário, nenhuma ação será realizada.
  Future<void> signOut() async {
    if (!isUserLoggedIn()) return;
    await _auth.signOut();
  }

  /// Retorna o nome de usuário do Firestore.
  ///
  /// Retorna o [username] do usuário autenticado.
  /// Caso contrário, retorna `null`.
  Future<String?> getUsername() async {
    final user = getUser();
    if (user == null) return null;

    final data = await _firestoreService.getUserData(user);
    return data["username"] as String?;
  }

  /// Retorna a URL da foto de perfil do Firestore.
  ///
  /// Retorna a URL da foto de perfil associada ao usuário autenticado.
  /// Caso contrário, retorna `null`.
  Future<String?> getPhotoURL() async {
    final user = getUser();
    if (user == null) return null;

    final data = await _firestoreService.getUserData(user);
    return data["photoURL"] as String?;
  }
}
