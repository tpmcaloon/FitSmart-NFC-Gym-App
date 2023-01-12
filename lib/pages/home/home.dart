import 'package:fitness_app/pages/home/widgets/activity.dart';
import 'package:fitness_app/pages/home/widgets/currrent.dart';
import 'package:fitness_app/pages/home/widgets/header.dart';
import 'package:flutter/material.dart';

import '../../widgets/bottomnavigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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