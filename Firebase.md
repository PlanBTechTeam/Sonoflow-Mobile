# Configuração do Firebase

Antigamente, precisávamos configurar cada projeto nativo manualmente, 
mas agora tem como fazer automaticamente pela CLI do Flutter. <br>

## 1. Instalar Dependências

### [CLI do Firebase](https://firebase.google.com/docs/cli?hl=pt&authuser=0#install_the_firebase_cli)
Em qualquer sistema, o mais fácil é instalar com `npm`:

```bash
$ npm install -g firebase-tools
```

Uma vez instalado, faça login no Firebase pela CLI:

```bash
$ firebase login
```

### Instalar a CLI do FlutterFire

No terminal, instale globalmente no sistema usando `dart pub`:

```bash
$ dart pub global activate flutterfire_cli
```

## 2. Configurar o Firebase

No diretório raíz do projeto, execute o comando para configurar o Firebase:

```bash
$ flutterfire configure --project=<projeto-do-firebase>
```

> Nota: `projeto-do-firebase` é o nome do projeto no Firebase, não é o projeto Flutter. <br>

O Flutterfire vai pedir o application id do Android e configurar tanto Android quanto IOS com o mesmo
nome no Firebase.
- Nesse caso, eu coloquei `com.sonoflow.sonoflow`, seguindo o padrão do package name do Android.

## 3. Inicializar o Firebase

Na função `main`, adicione as linhas:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
```

> Não esqueça de marcar a `main` como `async`.