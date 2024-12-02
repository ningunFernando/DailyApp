import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'navigation_screen.dart';
import './register_screen.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final url =
        Uri.parse('https://fertestflutter.guayabitos.site/api/login.php');
    final response = await http.post(url, body: {
      'email': _usernameController.text.trim(),
      'password': _passwordController.text.trim(),
    });

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['status'] == 'success') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('id', responseData['id'].toString());
        await prefs.setString('email', _usernameController.text);
        await prefs.setString('name', responseData['name']);
        await prefs.setString('lastname', responseData['lastname']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavigationScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${responseData['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la conexión: ${response.statusCode}')),
      );
    }
  }

  void MovePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).secondaryHeaderColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dai.ly',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            Image.asset('images/IconoApp.png', scale: 2),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              labelText: 'Usuario',
              prefixIcon: Icons.account_circle_outlined,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              labelText: 'Contraseña',
              isPassword: true,
              prefixIcon: Icons.lock_outline,
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: _login,
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(color: secondaryColor),
                  ),
                ),
                const SizedBox(height: 100),
                Text(
                  'No tienes cuenta?',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                  ),
                  onPressed: MovePage,
                  child: const Text('Regístrate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
