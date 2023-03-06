import 'package:fitness_app/pages/NFC/model/record.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NdefRecordPage extends StatelessWidget {
  const NdefRecordPage(this.index, this.record, {super.key});

  final int index;
  final NdefRecord record;

  @override
  Widget build(BuildContext context) {
    final info = NdefRecordInfo.fromNdef(record);
    return Scaffold(
      appBar: AppBar(
        title: Text(info.subtitle.replaceAll(('(en) '), ''),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          SizedBox(height: 12),
          Text('Set 1', style: TextStyle(color: Colors.white)),
          Text('Reps: ', style: TextStyle(color: Colors.white)),
          Text('Weight: ', style: TextStyle( color: Colors.white)),
          SizedBox(height: 12),
          Text('Set 2', style: TextStyle(color: Colors.white)),
          Text('Reps: ', style: TextStyle(color: Colors.white)),
          Text('Weight: ', style: TextStyle(color: Colors.white)),
          SizedBox(height: 12),
          Text('Set 3', style: TextStyle(color: Colors.white)),
          Text('Reps: ', style: TextStyle(color: Colors.white)),
          Text('Weight: ', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class NdefRecordInfo {
  const NdefRecordInfo({required this.record, required this.title, required this.subtitle});

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
