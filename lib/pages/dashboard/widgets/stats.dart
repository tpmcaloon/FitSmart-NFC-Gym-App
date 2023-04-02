import 'package:flutter/material.dart';
import 'package:health/health.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  String? heartRate;
  String? bp;
  String? steps;
  String? distance;
  String? activeEnergy;
  String? exerciseTime;
  String? flightsClimbed;

  List<HealthDataPoint> healthData = [];

  HealthFactory health = HealthFactory();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  /// Fetch data points from the health plugin and show them in the app.
  Future<void> fetchData() async {
    // Define the types to get
    final types = [
      HealthDataType.RESTING_HEART_RATE,
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.EXERCISE_TIME,
      HealthDataType.DISTANCE_WALKING_RUNNING,
      HealthDataType.FLIGHTS_CLIMBED
    ];

    // Get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    // Requesting access to the data types before reading them
    final isAuthorized = await health.requestAuthorization(types);

    if (isAuthorized) {
      try {
        // Fetch health data
        healthData = await health.getHealthDataFromTypes(yesterday, now, types);

        if (healthData.isNotEmpty) {
          for (final h in healthData) {
            if (h.type == HealthDataType.RESTING_HEART_RATE) {
              heartRate = '${h.value}';
            } else if (h.type == HealthDataType.STEPS) {
              steps = '${h.value}';
            } else if (h.type == HealthDataType.ACTIVE_ENERGY_BURNED) {
              activeEnergy = '${h.value}';
            } else if (h.type == HealthDataType.EXERCISE_TIME) {
              exerciseTime = '${h.value}';
            } else if (h.type == HealthDataType.FLIGHTS_CLIMBED) {
              flightsClimbed = '${h.value}';
            }
          }
          setState(() {});
        }
      } catch (error) {
        print('Exception in getHealthDataFromTypes: $error');
      }

      // Filter out duplicates
      healthData = HealthFactory.removeDuplicates(healthData);
    } else {
      print('Authorization not granted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: const [
              Text('Workout Stats',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.white
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.pie_chart_rounded,
              size: 15,
              color: Color.fromRGBO(30, 215, 96, 1),
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 30),
              InfoStat(
                icon: Icons.timer, 
                iconColor: const Color.fromRGBO(30, 215, 96, 1), 
                iconBackground: const Color.fromRGBO(50, 80, 50, 1), 
                time: '+5s', 
                label: 'Time', 
                value: '$exerciseTime'
              ),
              const SizedBox(width: 15),
              const InfoStat(
                icon: Icons.favorite_border_outlined, 
                iconColor: Color(0xffe11e6c),
                iconBackground: Color.fromRGBO(80,50,50,1),
                time: '+Intensity', 
                label: 'Heart Rate', 
                value: '167'
              ),
              const SizedBox(width: 15),
              InfoStat(
                icon: Icons.bolt, 
                iconColor: const Color(0xffd3b50f), 
                iconBackground: const Color.fromRGBO(80, 80, 50, 1), 
                time: '+30kcal', 
                label: 'Energy', 
                value: '$activeEnergy'
              ),
              const SizedBox(width: 15),
              InfoStat(
                icon: Icons.directions_walk, 
                iconColor: const Color.fromARGB(255, 15, 31, 211), 
                iconBackground: const Color.fromRGBO(60, 60, 100, 1), 
                time: '+30kcal', 
                label: 'Steps', 
                value: '$steps'
              ),
              const SizedBox(width: 15),
              InfoStat(
                icon: Icons.pin_drop, 
                iconColor: const Color.fromARGB(255, 139, 15, 211), 
                iconBackground: const Color.fromARGB(255, 77, 50, 80), 
                time: '+30kcal', 
                label: 'Distance', 
                value: '$distance'
              ),
              const SizedBox(width: 15),
              InfoStat(
                icon: Icons.stairs, 
                iconColor: const Color(0xffd3b50f), 
                iconBackground: const Color.fromRGBO(80, 80, 50, 1), 
                time: '+30kcal', 
                label: 'Flights Climbed', 
                value: '$flightsClimbed'
              ),
              const SizedBox(width: 30),
            ],
          ),
        )
      ],
    );
  }
}

class InfoStat extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String time;
  final String label;
  final String value;

  const InfoStat({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.time,
    required this.label,
    required this.value,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 110,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(50, 50, 50, 1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromRGBO(50, 50, 50, 1)
        ),
        boxShadow: const [BoxShadow(
          color: Color.fromRGBO(30, 215, 96, 0.5),
          offset: Offset(2,2),
          blurRadius: 3
        )]
      ),
      child: Stack(
        children: [
          StatIcon(
            icon: icon, 
            iconColor: iconColor, 
            iconBackground: iconBackground
          ),
          Change(time: time),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, 
                  style: const TextStyle(
                    fontSize: 10, 
                    color: Colors.white
                  ),
                ),
                Text(value,
                  style: const TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.w800, 
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Change extends StatelessWidget {
  const Change({
    Key? key,
    required this.time,
  }) : super(key: key);

  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 1, 
          horizontal: 4
        ),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(500)
        ),
        child: Text(
          time, 
          style: const TextStyle(fontSize: 10, color: Colors.white),)
      ),
    );
  }
}

class StatIcon extends StatelessWidget {
  const StatIcon({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: iconBackground,
        borderRadius: BorderRadius.circular(9)
      ),
      child: Icon(icon, size: 15, color: iconColor),
    );
  }
}