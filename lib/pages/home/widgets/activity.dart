import 'dart:math';

import 'package:flutter/material.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 35, 
          horizontal: 25
        ),
        color: const Color.fromRGBO(25, 20, 20, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Activities',
            style: Theme.of(context).textTheme.headline1
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder:(context, index) => const ActivityItem(), 
                ),
            )
          ],
        ),
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  const ActivityItem({super.key});

static const activities = [
  'Running',
  'Swimming',
  'Cycling',
  'Skiing',
  'Hiking',
  'Walking'
];

  @override
  Widget build(BuildContext context) {
    String activity = activities[Random().nextInt(activities.length)];
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/dashboard');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(30, 215, 96, 1)
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10,),
            Container(
              padding: const EdgeInsets.all(0.5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle, 
                color: Color.fromRGBO(30, 215, 96, 1),
              ),
              height: 35,
              width: 35,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/cardioProgramPic.jpg'),
                  fit: BoxFit.fill,
                  )
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(activity, 
            style: const TextStyle(
              fontSize: 12, 
              fontWeight: FontWeight.w900,
              color: Colors.white,
              ),
            ),
            const Expanded(child: SizedBox()),
            const Icon(Icons.timer, size: 12, color: Color.fromRGBO(30, 215, 96, 1)),
            const SizedBox(width: 5),
            const Text('30 Mins',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.white,),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.local_fire_department, size:12, color: Colors.amber,),
            const SizedBox(width: 5),
            const Text('72 Kcal',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.white,),
            ),
            const SizedBox(width: 20,)
          ],
        ),
      ),
    );
  }
}