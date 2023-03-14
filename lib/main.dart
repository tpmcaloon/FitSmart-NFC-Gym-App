import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/pages/NFC/NFCScan.dart';
import 'package:fitness_app/pages/auth/authcontroller.dart';
import 'package:fitness_app/pages/auth/signin.dart';
import 'package:fitness_app/pages/auth/signup.dart';
import 'package:fitness_app/pages/dashboard/dashboard.dart';
import 'package:fitness_app/pages/home/home.dart';
import 'package:fitness_app/pages/survey/survey.dart';
import 'package:fitness_app/pages/tracker/tracker.dart';
import 'package:fitness_app/pages/workoutDashboard/workout_dashboard.dart';
import 'package:fitness_app/pages/workoutLog/workoutlog.dart';
import 'package:fitness_app/pages/diary/diary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp().then((value) => Get.put(AuthController()));
SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FitSmart',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(40, 40, 40, 1),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(displayLarge: TextStyle(
          fontSize: 25,
          color: Color.fromRGBO(255, 255, 255, 1),
          fontWeight: FontWeight.w900
        )
        )
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        '/signin':(context) => const SignInPage(),
        '/signup':(context) => const SignUpPage(),
        '/dashboard':(context) => const DashboardPage(),
        '/tracker':(context) => const TrackerPage(key: null),
        '/workoutDashboard':(context) => const WorkoutDashboard(),
        '/workoutlog':(context) => const LogWorkoutPage(),
        '/tag_read':(context) => const NFCScanPage(),
        '/diary':(context) => const DiaryScreen(),
        'https://gja6ormyogx.typeform.com/to/r2dJh7Qx':(context) => const SurveyPage(),
      },
      initialRoute: '/signin',
    );
  }
}