import 'package:chat_app/presentation/pages/home_page.dart';
import 'package:chat_app/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviders>(context);

    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: 'Sign in failed');
        break;

      case Status.authenticated:
        Fluttertoast.showToast(msg: 'Sign in successful');
        break;

      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: 'Sign in cancelled');
        break;

      default:
        break;
    }
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Chat title login',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Login To Continue',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                bool isSuccess = await authProvider.handleGoogleSignIn();
                if (isSuccess) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: const Text('Sign In with Google',
                  style: TextStyle(color: Colors.white)),
            ),
            Center(
              child: authProvider.status == Status.authenticating
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}
