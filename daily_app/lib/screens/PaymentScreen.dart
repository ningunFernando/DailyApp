import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isPro = false;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPro = prefs.getBool('isPro') ?? false;
      _userId = prefs.getString('id'); // Obtener el ID desde SharedPreferences
    });
  }

  Future<void> _upgradeToPro() async {
    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ID de usuario no disponible')),
      );
      return;
    }

    final url = Uri.parse('https://fertestflutter.guayabitos.site/api/upgrade_to_premium.php');
    final response = await http.post(url, body: {
      'id': _userId,
      'pro': '1', // Enviar el valor "1" para activar la cuenta Pro
    });

    print('Response Body: ${response.body}'); // Para verificar la respuesta

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isPro', true);
        setState(() {
          _isPro = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('¡Felicidades! Ahora tienes acceso Pro.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${responseData['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar a Pro.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activar Cuenta Pro'),
      ),
      body: Center(
        child: _isPro
            ? Text('Ya eres usuario Pro. ¡Disfruta de tus beneficios!')
            : ElevatedButton(
          onPressed: _upgradeToPro,
          child: Text('Actualizar a Pro'),
        ),
      ),
    );
  }
}
