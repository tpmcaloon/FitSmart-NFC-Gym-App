import 'package:fitness_app/pages/dashboard/widgets/appbar.dart';
import 'package:fitness_app/pages/dashboard/widgets/dates.dart';
import 'package:fitness_app/pages/dashboard/widgets/graph.dart';
import 'package:fitness_app/pages/dashboard/widgets/info.dart' hide Stats;
import 'package:fitness_app/pages/dashboard/widgets/stats.dart';
import 'package:fitness_app/pages/dashboard/widgets/steps.dart';
import 'package:fitness_app/widgets/bottomnavigation.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
      appBar: MainAppBar(appBar: AppBar()),
      body: Column(
        children: const[
          Dates(),
          Steps(),
          Graph(),
          Info(),
          Divider(height: 30, color: Color.fromRGBO(50, 50, 50, 1),),
          Stats(),
          SizedBox(height: 30),
          BottomNavigation()
        ],
      ),
    );
  }
}