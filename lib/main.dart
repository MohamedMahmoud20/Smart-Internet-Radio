import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:radio/Controller/Provider.dart';
import 'package:radio/shared/network/local/local_db.dart';
import 'Screens/MainScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB.instance.database;
  runApp(ChangeNotifierProvider<DataProvider>(
      create: (BuildContext context) {
        return DataProvider()
          ..getAllItems()
          ..getAllMusicItems()
          ..getAllNewsItems()
          ..getAllQuranItems()
          ..getAllSportsItems()
          ..getFavItems();
      },
      child: const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late final controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1))
        ..repeat(reverse: true);

  late final Animation<double> animation =
      CurvedAnimation(parent: controller, curve: Curves.easeInCirc);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AnimatedSplashScreen(
          backgroundColor: Colors.deepPurple.withOpacity(0.8),
          splashIconSize: 500,
          splash: SingleChildScrollView(
            child: SizedBox(
              height: 450,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('lib/Json/82130-radio.json', fit: BoxFit.cover),
                  FadeTransition(
                    opacity: animation,
                    child: const Text(
                      "Internet Radio",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          ),
          nextScreen: home_screen(),
        ),
      ),
    );
  }
}
