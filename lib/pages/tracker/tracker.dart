import 'package:fitness_app/pages/tracker/widgets/appbar.dart';
import 'package:fitness_app/pages/tracker/widgets/activities.dart';
import 'package:fitness_app/pages/tracker/widgets/tracker_map.dart';
import 'package:fitness_app/widgets/bottomnavigation.dart';
import 'package:flutter/material.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
      appBar: MainAppBar(appBar: AppBar()),
      body: Column(
        children: const[
          TrackerMap(),
          TrackerActivities(),
          BottomNavigation()
        ],
      ),
    );
  }
}