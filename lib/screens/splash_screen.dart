import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:losts_app/providers/items_provider.dart';
import 'package:losts_app/screens/tabs_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemProvider>(context, listen: false).checkServerStatus();

    // .then(
    //     (value) => {Navigator.of(context).pushNamed(TabsScreen.routeName)});
    // context.watch<ItemProvider>().checkServerStatus().then(
    //     (value) => {Navigator.of(context).pushNamed(TabsScreen.routeName)});
    // Future.delayed(Duration(seconds: 3), () {
    //   Navigator.of(context).pushNamed(TabsScreen.routeName);
  }

  // context.watch<ItemProvider>().checkServerStatus().then((value) => {
  //   Navigator.of(context).pushNamed(TabsScreen.routeName)
  // });
  // }

  @override
  Widget build(BuildContext context) {
    bool status = true;
    //= context.read<ItemProvider>().serverLoading;
    if (context.read<ItemProvider>().errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.read<ItemProvider>().errorMessage)));
    }
    context.read<ItemProvider>().checkServerStatus().then(
        (value) => {Navigator.of(context).pushNamed(TabsScreen.routeName)});
    // animated splash screen
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF00BFA5),
                  Color(0xFF00BFA5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //circle avatar
                    CircleAvatar(
                      radius: 150.0,
                      backgroundColor: Colors.transparent,
                      child: SizedBox(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "assets/images/bayan-logo-3.png",
                              ))),
                    ),

                    // CircleAvatar(
                    //   backgroundColor: Colors.white,
                    //   radius: 50.0,
                    //   child: Image.asset("assets/images/lostBag.jpg"),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Text(
                      " تطبيق المفقودات في الحرم الجامعي ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    status
                        ? Text(
                            "جاري التحميل",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            "تم التحميل",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
