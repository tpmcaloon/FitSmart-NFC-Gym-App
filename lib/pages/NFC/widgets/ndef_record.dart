import 'package:fitness_app/pages/NFC/model/record.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NdefRecordPage extends StatefulWidget {
  const NdefRecordPage(this.index, this.record, {Key? key}) : super(key: key);

  final int index;
  final NdefRecord record;

  @override
  _NdefRecordPageState createState() => _NdefRecordPageState();
}

class _NdefRecordPageState extends State<NdefRecordPage> {
  String _name = '';
  List<Map<String, dynamic>> _sets = [    {'reps': '', 'weight': ''}  ];

  // Firestore instance
  final _firestore = FirebaseFirestore.instance;

  // Function to save the exercise data to Firestore
  Future<void> _saveExercise() async {
    try {
      // Create a new document for the exercise record
      await _firestore.collection('exercises').add({
        'name': _name,
        'sets': _sets,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Navigator.pop(context);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exercise saved successfully')),
      );

    } catch (error) {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = NdefRecordInfo.fromNdef(widget.record);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          info.subtitle.replaceAll(('(en) '), ''),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _sets.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Text('Set ${index + 1}', style: const TextStyle(color: Color(0xFF1DB954), fontWeight: FontWeight.w900, fontSize: 25)),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter reps',
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            _sets[index]['reps'] = value;
                            _name = info.subtitle.replaceAll(('(en) '), '');
                          });
                        },
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter weight (Kg)',
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            _sets[index]['weight'] = value;
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(30, 215, 96, 1),
              ),
              onPressed: () {
                _saveExercise();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(30, 215, 96, 1),
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            _sets.add({'reps': '', 'weight': ''});
          });
        },
      ),
    );
  }
}

class NdefRecordInfo {
  const NdefRecordInfo({
    required this.record,
    required this.title,
    required this.subtitle,
  });

  final Record record;

  final String title;

  final String subtitle;

  static NdefRecordInfo fromNdef(NdefRecord record) {
    final _record = Record.fromNdef(record);
    if (_record is WellknownTextRecord) {
      return NdefRecordInfo(
        record: _record,
        title: 'Exercise',
        subtitle: '(${_record.languageCode}) ${_record.text}',
      );
    }
    throw UnimplementedError();
  }
}