import 'package:flutter/material.dart';
import 'package:losts_app/widgets/search_icon.dart';

import '../widgets/main_drawer.dart';
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
        appBar: AppBar(
          title: Text(
            _screens[_selectedScreenIndex]['title'],
          ),
          actions: const [
            SearchIcon(),
          ],
        ),
        drawer: MainDrawer(),
        body: _screens[_selectedScreenIndex]['screen'],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onTap: _selectScreen,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          currentIndex: _selectedScreenIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 30,
              ),
              label: 'Lost',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_florist,
                size: 30,
              ),
              label: 'Found',
            ),
          ],
        ),
      ),
    );
  }
}
