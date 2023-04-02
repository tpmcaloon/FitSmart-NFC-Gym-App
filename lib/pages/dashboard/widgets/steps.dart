import 'package:flutter/material.dart';
import 'package:health/health.dart';

class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);

  @override
  _StepsState createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  String? steps;

  List<HealthDataPoint> healthData = [];

  HealthFactory health = HealthFactory();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  /// Fetch data points from the health plugin and show them in the app.
  Future fetchData() async {
    // define the types to get
    final types = [
      HealthDataType.STEPS,
    ];

    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    // requesting access to the data types before reading them
    bool requested = await health.requestAuthorization(types);

    if (requested) {
      try {
        healthData = await health.getHealthDataFromTypes(yesterday, now, types);
        if (healthData.isNotEmpty) {
          for (HealthDataPoint h in healthData) {
            if (h.type == HealthDataType.STEPS) {
              steps = "${h.value}";
            }
          }
          setState(() {});
        }
        healthData = HealthFactory.removeDuplicates(healthData);
      } catch (error) {
        print("Exception in getHealthDataFromTypes: $error");
      }
    } else {
      print("Authorization not granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
        color:Color.fromRGBO(25, 20, 20, 1),
      ),
      child: Column(
        children: [
          Text('$steps', 
            style: TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 2
            ),
          ),
          Text('Total Steps', 
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.5
            ),
          ),
        ],
      ),
    );
  }
}