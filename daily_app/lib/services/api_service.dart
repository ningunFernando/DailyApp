import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://fertestflutter.guayabitos.site/api";

  // Registro de usuario
  Future<Map<String, dynamic>> registerUser(String name, String lastName, String email, String password, String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register.php'),
      body: {
        'nombre': name,
        'apellido': lastName,
        'correo': email,
        'contrasena': password,
        'telefono': phone,
      },
    );

    try {
      final decodedJson = json.decode(response.body.trim());
      return decodedJson;
    } catch (e) {
      return {"status": "error", "message": "Error en la decodificación JSON"};
    }
  }

  // Inicio de sesión
  Future<Map<String, dynamic>> loginUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}login.php'),
        body: {
          'username': username,
          'password': password,
        },
      );

      // Decodificar JSON
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // Verificar el estado de éxito en la respuesta
      if (responseData['status'] == 'success') {
        return {
          'success': true,
          'data': responseData,
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Error desconocido',
        };
      }
    } catch (error) {
      return {
        'success': false,
        'message': 'Error de red o formato incorrecto de respuesta',
      };
    }
  }

  // Editar perfil
  Future<Map<String, dynamic>> editProfile(
      int usuarioId, String nombre, String apellido, String correo, String telefono) async {
    final response = await http.post(
      Uri.parse('$baseUrl/edit_profile.php'),
      body: {
        'usuario_id': usuarioId.toString(),
        'nombre': nombre,
        'apellido': apellido,
        'correo': correo,
        'telefono': telefono,
      },
    );

    return _processResponse(response);
  }

  // Cambiar estado pro
  Future<Map<String, dynamic>> toggleProStatus(int usuarioId, int pro) async {
    final response = await http.post(
      Uri.parse('$baseUrl/toggle_pro_status.php'),
      body: {
        'usuario_id': usuarioId.toString(),
        'pro': pro.toString(),
      },
    );

    return _processResponse(response);
  }

  //fetch username
  Future<String?> fetchUsername(int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/fetch_username.php'),
      body: {'user_id': userId.toString()},
    );

    final data = json.decode(response.body);
    if (data['status'] == 'success') {
      return data['nombre'];
    } else {
      print("Error: ${data['message']}");
      return null;
    }
  }

  // Procesar respuesta
  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }
}