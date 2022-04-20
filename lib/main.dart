import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart'; //splash screen import
import 'SplashAnimation.dart';
import 'package:firebase_core/firebase_core.dart';
void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print

    await Future.delayed(const Duration(seconds: 1));
    print('ready....');
    await Firebase.initializeApp().whenComplete(() {
      print("completed");
    });

    FlutterNativeSplash.remove();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroPage(),
    );
  }
}
