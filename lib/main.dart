import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'features/login/controllers/login_controller.dart';
import 'features/login/controllers/register_controller.dart';
import 'features/login/views/login_view.dart';
import 'app/routes/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NBA Fantasy App',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      // themeMode: ThemeMode.light,
      initialBinding: _InitialBinding(),
      initialRoute: AppRoute.login.path,
      getPages: AppRouter.pages,
    );
  }
}

class _InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<RegisterController>(() => RegisterController(), fenix: true);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    this.auth,
    this.httpClient,
  });

  final String title;
  final FirebaseAuth? auth;
  final http.Client? httpClient;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  String? _resultText;
  bool _loading = false;

  FirebaseAuth get _auth => widget.auth ?? FirebaseAuth.instance;
  http.Client get _client => widget.httpClient ?? http.Client();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _resultText = '請輸入 Email 與 Password';
      });
      return;
    }
    setState(() {
      _loading = true;
      _resultText = null;
    });
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = _auth.currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) {
        setState(() {
          _resultText = '無法取得 idToken';
        });
        return;
      }
      final uri = Uri.parse('http://localhost:3000/auth/login');
      final resp = await _client.post(
        uri,
        headers: {
          'Authorization': 'Bearer $idToken',
        },
      );
      setState(() {
        _resultText = resp.body;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _resultText = '錯誤(${e.code}): ${e.message}';
      });
    } catch (e) {
      setState(() {
        _resultText = '錯誤: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              key: const ValueKey('emailField'),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const ValueKey('passwordField'),
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const ValueKey('loginButton'),
              onPressed: _loading ? null : _login,
              child: _loading
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('登入'),
            ),
            const SizedBox(height: 20),
            if (_resultText != null)
              Text(
                _resultText!,
                key: const ValueKey('resultText'),
              ),
          ],
        ),
      ),
    );
  }
}
