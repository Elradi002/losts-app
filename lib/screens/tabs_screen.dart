import 'package:flutter/material.dart';

import '../models/language_constants.dart';
import 'founds_screen.dart';
import 'lost_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  const TabsScreen({super.key});
  @override
  State<StatefulWidget> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map> _screens = [
    {'screen': const LostScreen(), 'title': 'Lost & Found'},
    {'screen': const FoundScreen(), 'title': 'Lost & Found'},
  ];
  int _selectedScreenIndex = 0;
  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[_selectedScreenIndex]['screen'],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onTap: _selectScreen,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          selectedItemColor: Colors.white,
          currentIndex: _selectedScreenIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
              label: translation(context).lost,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.local_florist,
                size: 30,
              ),
              label: translation(context).found,
            ),
          ],
        ),
      ),
    );
  }
}
