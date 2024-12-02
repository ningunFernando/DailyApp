import 'package:daily_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import './home_screen.dart';
import './store_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import './PaymentScreen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    StoreScreen(),
    PaymentScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar:
      Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: GNav(
            backgroundColor: primaryColor,
            tabBackgroundColor: Colors.green.shade300,
            padding: EdgeInsets.all(16),
            color: Colors.white,
            activeColor: Colors.white,
              duration: Duration(milliseconds: 400),
            gap: 10,
              tabs: const [
                GButton(
                    icon: Icons.calendar_month_rounded,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.store_outlined,
                  text: 'Store',
                ),
                GButton(
                  icon: Icons.star,
                  text: 'Pro',
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: 'User',
                ),

              ],
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
               ),
        ),
      ),
    );
  }
}
