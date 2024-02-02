import 'package:flutter/material.dart';

import 'screens/belum_dikerjakan_screen.dart';
import 'screens/dikerjakan_screen.dart';
import 'screens/ditunda_screen.dart';
import 'screens/selesai_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int i = 0;
  List<Widget> screens = [
    const BelumDikerjakanScreen(),
    const DikerjakanScreen(),
    const DitundaScreen(),
    const SelesaiScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[i],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: i,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Baru",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.engineering),
            label: "Dikerjakan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: "Ditunda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: "Selesai",
          ),
        ],
        onTap: (value) {
          print(value);
          setState(() {
            i = value;
          });
        },
      ),
    );
  }
}
