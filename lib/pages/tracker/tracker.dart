import 'package:flutter/material.dart';
import 'package:fitness_app/pages/tracker/widgets/map.dart';
import 'package:fitness_app/models/tracker_entry.dart';
import 'package:fitness_app/pages/tracker/widgets/entry_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/pages/tracker/widgets/appbar.dart';
import '../../widgets/bottomnavigation.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({Key? key}) : super(key: key);

  @override
  _TrackerPageState createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  List<EntryCard> _cards = [];
  late CollectionReference<Map<String, dynamic>> _entriesCollection;

  @override
  void initState() {
    super.initState();
    _entriesCollection = FirebaseFirestore.instance.collection('gpsTracker');
    _fetchEntries();
  }

  void _fetchEntries() async {
    // Retrieve the collection from Firestore
    final snapshot = await FirebaseFirestore.instance.collection('gpsTracker').get();
    // Convert each document in the collection to an Entry object
    final data = snapshot.docs.map((doc) => Entry.fromMap(doc.data())).toList();
    // Create an EntryCard for each Entry object and add it to the _cards list
    _cards = data.map((entry) => EntryCard(entry: entry)).toList();
    // Update the UI
    setState(() {});
  }

  void _addEntries(Entry entry) async {
    await _entriesCollection.add(entry.toMap());
    _fetchEntries();
  }

  void _deleteEntry(String id) async {
    await _entriesCollection.doc(id).delete();
    _fetchEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBar: AppBar()),
      body: ListView(
        children: _cards,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MapPage())
        ).then((value) {
          if (value != null) {
            _addEntries(value);
          }
        }),
        tooltip: 'Add Entry',
        backgroundColor: const Color.fromRGBO(30, 215, 96, 1),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}