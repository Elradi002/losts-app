import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:losts_app/screens/lost_item_details_screen.dart';
import 'package:losts_app/screens/lost_screen.dart';
import 'package:losts_app/screens/search_screen.dart';
import 'package:losts_app/screens/splash_screen.dart';
import 'package:losts_app/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

import './screens/found_item_details_screen.dart';
import 'models/language_constants.dart';
import 'providers/items_provider.dart';

void main() => runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ItemProvider())],
    child: const MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: SplashScreen(),
      routes: {
        TabsScreen.routeName: (context) => const TabsScreen(),
        // SearchScreen.routeName: (context) => const SearchScreen(),
        LostItemDetailsScreen.routeName: (context) => LostItemDetailsScreen(),
        FoundItemDetailsScreen.routeName: (context) => FoundItemDetailsScreen(),
        LostScreen.routeName: (context) => LostScreen(),
      },
    );
  }
}
