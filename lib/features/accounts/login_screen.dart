import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'utils/sparkapp_auth.dart';
import '../../settings/app_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final AppConfig _appConfig = AppConfig();
  final AuthSparkapp _auth = AuthSparkapp();
  @override
  void initState() {
    super.initState();
    _checkIsAuthenticated();
  }

  Future<void> _checkIsAuthenticated() async {
    final refreshToken = await _appConfig.refreshToken;
    if (refreshToken != null && context.mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) => context.go('/'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[100]!, // Adjust colors as desired
              Colors.blue[900]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center horizontally
            children: <Widget>[
              const SizedBox(height: 20), // Add some spacing
              ElevatedButton(
                // Changed to ElevatedButton for better visual appeal
                onPressed: () async {
                  setState(() => isLoading = true);
                  final success = await _auth.loginSparkapp();
                  if (success && context.mounted) {
                    setState(() => isLoading = false);
                    context.go('/');
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Error al iniciar sesión')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  backgroundColor: Colors.white, // Or a contrasting color
                  textStyle: const TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // Rounded corners
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, // Better control of size
                  children: <Widget>[
                    Image.asset(
                      'assets/google.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(
                        width: 10), // Add spacing between icon and text
                    Text(
                      'Iniciar sesión con Google', // More descriptive text
                      style: TextStyle(fontSize: 18, color: Colors.blue[900]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Add spacing
              // Animacion circular si isAuthenticated es true
              if (isLoading) const CircularProgressIndicator(strokeWidth: 2)
            ],
          ),
        ),
      ),
    );
  }
}
