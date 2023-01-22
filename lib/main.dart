import 'package:fitness_app/pages/auth/signin.dart';
import 'package:fitness_app/pages/auth/signup.dart';
import 'package:fitness_app/pages/dashboard/dashboard.dart';
import 'package:fitness_app/pages/home/home.dart';
import 'package:fitness_app/pages/tracker/tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


void main() {
WidgetsFlutterBinding.ensureInitialized();
SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        fontFamily: 'Roboto',
        textTheme: const TextTheme(headline1: TextStyle(
          fontSize: 25,
          color: Color.fromRGBO(255, 255, 255, 1),
          fontWeight: FontWeight.w900
        ))
      ),
      debugShowCheckedModeBanner: true,
      routes: {
        '/': (context) => const HomePage(),
        '/signin':(context) => const SignInPage(),
        '/signup':(context) => const SignUpPage(),
        '/dashboard':(context) => const DashboardPage(),
        '/tracker':(context) => const TrackerPage(),
      },
      initialRoute: '/signin',
    );
  }
}