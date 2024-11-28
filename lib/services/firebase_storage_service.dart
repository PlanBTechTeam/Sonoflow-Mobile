import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

/// Serviço de integração com o Firebase Storage.
///
/// Fornece métodos para upload e manipulação de arquivos no Firebase Storage.
class FirebaseStorageService {
  final Reference ref;

  /// Construtor padrão.
  ///
  /// Inicializa o serviço com uma referência ao Firebase Storage.
  FirebaseStorageService() : ref = FirebaseStorage.instance.ref();

  /// Faz o upload de um arquivo para o Firebase Storage.
  ///
  /// [fileName]: O nome do arquivo a ser salvo no Firebase Storage.
  /// [file]: O conteúdo do arquivo em formato binário.
  ///
  /// Retorna a URL pública do arquivo carregado como uma `String` em caso de sucesso,
  /// ou `null` em caso de falha.
  ///
  /// Exceções:
  /// - Em caso de erro durante o upload, captura a exceção e retorna `null`.
  Future<String?> uploadFile(String fileName, Uint8List file) async {
    try {
      final imageRef = ref.child(fileName);
      UploadTask uploadTask = imageRef.putData(file);
      TaskSnapshot snapshot = await uploadTask;

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }
}
