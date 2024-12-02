import 'dart:convert';
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import './navigation_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

  Future<void> _register() async {
    // Verificar si los correos coinciden
    if (_emailController.text != _confirmEmailController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Los correos electrónicos no coinciden')),
      );
      return; // Detiene el registro si los correos no coinciden
    }

    // Verificar si las contraseñas coinciden
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return; // Detiene el registro si las contraseñas no coinciden
    }

    // Verificar si los campos de nombre, apellido y teléfono están llenos
    if (_nameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return; // Detiene el registro si alguno de estos campos está vacío
    }

    final url =
        Uri.parse('https://fertestflutter.guayabitos.site/api/register.php');
    final response = await http.post(url, body: {
      'email': _emailController.text,
      'password': _passwordController.text,
      'name': _nameController.text,
      'lastname': _lastNameController.text,
      'phone': _phoneController.text,
    });

    // Imprimir el estado y cuerpo de la respuesta
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['status'] == 'success') {
        // Guardar los datos en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('email', _emailController.text);
        await prefs.setString('name', _nameController.text);
        await prefs.setString('lastname', _lastNameController.text);
        await prefs.setString('phone', _phoneController.text);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavigationScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Error en el registro: ${responseData['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la conexión: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Image.asset('images/IconoApp.png', scale: 4),
            CustomTextField(
              labelText: 'Correo',
              prefixIcon: Icons.email_outlined,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              labelText: 'Confirmar Correo',
              prefixIcon: Icons.email_outlined,
              controller: _confirmEmailController,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_outline,
              controller: _passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              labelText: 'Confirmar Contraseña',
              prefixIcon: Icons.lock_outline,
              controller: _confirmPasswordController,
              isPassword: true,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              labelText: 'Nombre',
              prefixIcon: Icons.account_circle_outlined,
              controller: _nameController,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              labelText: 'Apellido',
              prefixIcon: Icons.account_circle_outlined,
              controller: _lastNameController,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              keyboardType: TextInputType.number,
              labelText: 'Teléfono',
              prefixIcon: Icons.phone_android_outlined,
              controller: _phoneController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: _register,
              child: const Text('Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}
