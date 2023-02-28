import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewWorkoutPage extends StatefulWidget {
  const ViewWorkoutPage({super.key});

  @override
  _LogWorkoutPageState createState() => _LogWorkoutPageState();
}

class _LogWorkoutPageState extends State<ViewWorkoutPage> {
  final CollectionReference _workouts =
  FirebaseFirestore.instance.collection('sets');

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Scaffold(
        body: StreamBuilder(
        stream: _workouts.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const FlutterLogo(size: 72.0),
                    title: Text('${documentSnapshot['exercise']}'),
                    subtitle: Text('Reps: ${documentSnapshot['reps']} ' 'Weight: ${documentSnapshot['weight']}'),
                    trailing: const Icon(Icons.more_vert),
                    isThreeLine: true,
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
        )
    );
  }
}