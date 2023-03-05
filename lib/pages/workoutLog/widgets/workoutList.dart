import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewWorkoutPage extends StatefulWidget {
  const ViewWorkoutPage({super.key});

  @override
  _LogWorkoutPageState createState() => _LogWorkoutPageState();
}

class _LogWorkoutPageState extends State<ViewWorkoutPage> {
  final CollectionReference _workouts =
  FirebaseFirestore.instance.collection('workout');
  // final CollectionReference _exercises =
  // FirebaseFirestore.instance.collection('workout/Dh84zosLMmjgRJkQYvWx/exercises');
  // final CollectionReference _sets =
  // FirebaseFirestore.instance.collection('workout/Dh84zosLMmjgRJkQYvWx/exercises/DWD92TbHIcNGz7uqdc12/sets');

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
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color.fromRGBO(30, 215, 96, 1),
                                width: 2
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: const Color.fromRGBO(25, 20, 20, 1),
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: const FlutterLogo(size: 72.0),
                            title: Text('${documentSnapshot['name']}',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
                            subtitle: Text('Date: ${DateTime.parse(documentSnapshot['date'].toDate().toString())}''   Type: ${documentSnapshot['type']}',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
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
            ),
    );
  }
}