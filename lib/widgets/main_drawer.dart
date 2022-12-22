import 'package:flutter/material.dart';
import 'package:losts_app/screens/tabs_screen.dart';

import '../models/constants.dart';
import '../screens/search_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListTile(String title, IconData icon, VoidCallback onTabHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(
        title,
        style: kLargeTittle,
      ),
      onTap: onTabHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.secondary,
            child: const Text(
              'Lists',
              style: kAppBarTheme,
            ),
          ),
          const SizedBox(height: 20),
          buildListTile(
            'Search',
            Icons.search,
            () {
              Navigator.of(context).pushNamed(SearchScreen.routeName);
            },
          ),
          buildListTile(
            'List of lost',
            Icons.list,
            () {
              Navigator.of(context).pushNamed(TabsScreen.routeName);
            },
          ),
          buildListTile(
            'List of found',
            Icons.local_florist,
            () {
              Navigator.of(context).pushNamed(TabsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
