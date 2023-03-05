import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/pages/home/widgets/activity.dart';
import 'package:fitness_app/pages/home/widgets/current.dart';
import 'package:fitness_app/pages/home/widgets/header.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottomnavigation.dart';
import '../auth/authcontroller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final User? user = FirebaseAuth.instance.currentUser;
    final displayName = user?.email ?? "No Username";
    const userProfile = AssetImage('assets/profilePic.jpg');

    return Scaffold(
        drawer: Drawer(
          backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: h*0.125,
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(30, 215, 96, 1),
                  ),
                  child: Text('FitSmart',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 35
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const CircleAvatar(backgroundImage: userProfile),
                title: Text('Signed in as $displayName',
                  style: const TextStyle(
                      color: Colors.white
                  ),
                ),
              ),

              SizedBox(height: h*0.05),

              ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
                title: const Text('Home',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/');
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_chart, color: Colors.white),
                title: const Text('Dashboard',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/dashboard');
                },
              ),
              ListTile(
                leading: const Icon(Icons.fitness_center, color: Colors.white),
                title: const Text('Workout',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/workoutDashboard');
                },
              ),
              ListTile(
                leading: const Icon(Icons.book, color: Colors.white),
                title: const Text('Diary',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/diary');
                },
              ),
              ListTile(
                leading: const Icon(Icons.gps_fixed, color: Colors.white),
                title: const Text('Tracker',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/tracker');
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text('Logout',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  AuthController.instance.signOut();
                },
              ),
            ],
          ),
        ),
      body: Column(
        children: const[
          AppHeader(),
          CurrentProgrammes(),
          RecentActivities(),
          BottomNavigation(),
        ],
      ),
    );
  }
}