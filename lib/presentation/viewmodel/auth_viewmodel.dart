import 'package:firebase_auth/firebase_auth.dart';
import 'package:sonoflow/services/firebase_auth_service.dart';

/// ViewModel responsável por gerenciar a autenticação.
///
/// Atua como uma camada intermediária entre a interface do usuário e os serviços
/// de autenticação, encapsulando a lógica para registro e login de usuários.
class AuthViewmodel {
  final FirebaseAuthService _auth = FirebaseAuthService();

  /// Registra um novo usuário.
  ///
  /// [username]: Nome de usuário do novo usuário.<br>
  /// [email]: Endereço de e-mail do novo usuário.<br>
  /// [password]: Senha escolhida pelo novo usuário.<br>
  ///
  /// Chama o método [FirebaseAuthService.registerWithUserInformation]
  /// para completar o registro.
  ///
  /// Retorna um objeto [User] em caso de sucesso ou lança uma [FirebaseAuthException] em caso de erro.
  ///
  /// TODO: handle profile picture
  Future<User?> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.registerWithUserInformation(
        username: username, email: email, password: password,
        // TODO
        // sleepGoal: ,
        // picture: ,
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }

  /// Realiza login de um usuário existente.
  ///
  /// [email]: Endereço de e-mail do usuário.<br>
  /// [password]: Senha do usuário.<br>
  ///
  /// Chama o método [FirebaseAuthService.loginWithEmailAndPassword]
  /// para autenticar o usuário.
  ///
  /// Retorna um objeto [User] em caso de sucesso ou lança uma [FirebaseAuthException] em caso de erro.
  Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.loginWithEmailAndPassword(email, password);
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
