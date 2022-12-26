import 'package:flutter/material.dart';
import 'package:losts_app/screens/founds_screen.dart';
import 'package:losts_app/screens/lost_item_details_screen.dart';
import 'package:losts_app/screens/search_screen.dart';
import 'package:losts_app/screens/tabs_screen.dart';
import 'package:provider/provider.dart';
import 'providers/items_provider.dart';
import './screens/found_item_details_screen.dart';
import './screens/splash_screen.dart';
void main() => runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ItemProvider())
      ],
    child: const MyApp()));

class MyApp extends StatefulWidget {
  
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ItemProvider>(context, listen: false).getFounds();
    Provider.of<ItemProvider>(context, listen: false).getLosts();
    super.initState();
  }
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
      home:  SplashScreen(),
      routes: {
        TabsScreen.routeName: (context) => const TabsScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
        LostItemDetailsScreen.routeName: (context) => const LostItemDetailsScreen(),
        FoundItemDetailsScreen.routeName: (context) => const FoundItemDetailsScreen(),
      },
    );
  }
}
