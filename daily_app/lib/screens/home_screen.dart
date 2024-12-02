import 'package:daily_app/widgets/day_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import '../screens/Edit_screen.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? '';
    final lastname = prefs.getString('lastname') ?? '';
    setState(() {
      username = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bienvenido, ${username ?? 'Usuario'}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: const [
              CustomDayCard(
                imageNumber: 2,
              ),
              SizedBox(
                height: 25,
              ),
              CustomDayCard(
                imageNumber: 1,
              ),
              SizedBox(
                height: 25,
              ),
              CustomDayCard(
                imageNumber: 3,
              ),
              SizedBox(
                height: 25,
              ),
              CustomDayCard(
                imageNumber: 4,
              )
            ],
          )),
    );
  }
}
