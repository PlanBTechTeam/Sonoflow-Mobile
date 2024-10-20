import 'package:flutter/material.dart';
import 'package:sonoflow/presentation/utils/colors.dart';
import 'package:sonoflow/presentation/view/dashboard/dashboard_screen.dart';
import 'package:sonoflow/presentation/view/home/home_screen.dart';
import 'package:sonoflow/presentation/view/settings/setting_screen.dart';

class AuthProvider extends StatefulWidget {
  const AuthProvider({super.key});

  @override
  State<AuthProvider> createState() => _AuthProviderState();
}

class _AuthProviderState extends State<AuthProvider> {
  // ===== INDEX VALUE TO SCREEN =====
  int _currentIndex = 1;

  // ===== LIST SCREEN TO ROUTE
  List<Widget> body = const [
    DashboardScreen(),
    HomeScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(12, 31, 61, 1),
            image: DecorationImage(
                image: AssetImage('assets/auth_background.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Image(image: AssetImage("assets/sonoflow-logo.png")),
            Center(
              child: body[_currentIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.goldenYellow,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: <BottomNavigationBarItem>[
          // ===== DASHBOARD ICON =====
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/dashboard.png'),
            activeIcon: Image.asset('assets/icons/dashboard-active.png'),
            label: 'Dashboard',
          ),

          // ===== HOME ICON =====
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home.png'),
            activeIcon: Image.asset('assets/icons/home-active.png'),
            label: 'Home',
          ),

          // ===== SETTINGS ICON =====
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/setting.png'),
              activeIcon: Image.asset('assets/icons/setting-active.png'),
              label: 'Configurações')
        ],
      ),
    );
  }
}
