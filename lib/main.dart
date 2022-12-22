import 'package:flutter/material.dart';
import 'package:losts_app/screens/lost_item_details_screen.dart';
import 'package:losts_app/screens/search_screen.dart';
import 'package:losts_app/screens/tabs_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost & Found ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
          accentColor: Colors.teal[300],
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const TabsScreen(),
      routes: {
        TabsScreen.routeName: (ctx) => const TabsScreen(),
        SearchScreen.routeName: (ctx) => const SearchScreen(),
        LostItemDetailsScreen.routeName: (ctx) => const LostItemDetailsScreen(),
      },
    );
  }
}
