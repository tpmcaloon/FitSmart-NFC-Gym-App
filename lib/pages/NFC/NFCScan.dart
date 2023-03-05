import 'package:fitness_app/pages/NFC/widgets/tag_read.dart';
import 'package:fitness_app/pages/NFC/widgets/appbar.dart';
import 'package:fitness_app/widgets/bottomnavigation.dart';
import 'package:flutter/material.dart';

class NFCScanPage extends StatelessWidget {
  const NFCScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
      appBar: MainAppBar(appBar: AppBar()),
      body: Column(
        children: const [
          TagReadPage(),
          BottomNavigation()
        ],
      ),
    );
  }
}