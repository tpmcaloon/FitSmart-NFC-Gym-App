import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewWorkoutPage extends StatefulWidget {
  const ViewWorkoutPage({Key? key}) : super(key: key);

  @override
  _ViewWorkoutPageState createState() => _ViewWorkoutPageState();
}

class _ViewWorkoutPageState extends State<ViewWorkoutPage> {
  final CollectionReference _workouts =
  FirebaseFirestore.instance.collection('exercises');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: StreamBuilder(
          stream: _workouts.snapshots(),
          builder:
              (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              final workouts = streamSnapshot.data!.docs;
              final groupedWorkouts =
              groupByDay(workouts);
              final tiles = groupedWorkouts.entries
                  .map((entry) =>
                  buildDayTile(context, entry.key, entry.value))
                  .toList();
              return ListView(children: tiles);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Map<DateTime, List<DocumentSnapshot>> groupByDay(
      List<DocumentSnapshot> workouts) {
    final Map<DateTime, List<DocumentSnapshot>> groupedWorkouts = {};
    for (final workout in workouts) {
      final DateTime date = workout['timestamp'].toDate();
      final DateTime day = DateTime(date.year, date.month, date.day);
      if (!groupedWorkouts.containsKey(day)) {
        groupedWorkouts[day] = [];
      }
      groupedWorkouts[day]!.add(workout);
    }
    return groupedWorkouts;
  }

  Widget buildDayTile(BuildContext context, DateTime date,
      List<DocumentSnapshot> workouts) {
    return GestureDetector(
      onTap: () => _onDayTileTap(context, date, workouts),
      child: Card(
        shape: RoundedRectangleBorder(
          side:
          const BorderSide(color: Color.fromRGBO(30, 215, 96, 1), width: 2),
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: const Color.fromRGBO(25, 20, 20, 1),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                'Workout - ${date.day}/${date.month}/${date.year}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
              ),
            ),
            ...workouts.map((workout) => buildWorkoutTile(workout)).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildWorkoutTile(DocumentSnapshot workout) {
    final List<dynamic> sets = workout['sets'];
    final List<Widget> setTiles = sets.map((set) {
      final int reps = int.parse(set['reps']);
      final int weight = int.parse(set['weight']);
      return ListTile(
        title: Text('Set: $reps x $weight kg',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400)
        ),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const FlutterLogo(size: 40.0),
          title: Text('${workout['name']}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
          subtitle: Text('Total Sets: ${sets.length}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
          trailing: const Icon(Icons.more_vert),
        ),
        const Divider(color: Colors.white),
        ...setTiles,
      ],
    );
  }

  void _onDayTileTap(BuildContext context, DateTime date,
      List<DocumentSnapshot> workouts) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
                title: Text('${date.month}/${date.day}/${date.year}'),
              ),
              body: ListView(
                children: workouts.map((workout) => buildWorkoutTile(workout))
                    .toList(),
              ),
            ),
      ),
    );
  }
}
