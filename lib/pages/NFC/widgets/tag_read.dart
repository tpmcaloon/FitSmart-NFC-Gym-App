import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/pages/NFC/common/form_row.dart';
import 'package:fitness_app/pages/NFC/common/nfc_session.dart';
import 'package:fitness_app/pages/NFC/widgets/ndef_record.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';

class TagReadModel with ChangeNotifier {
  List<NfcTag> tags = [];

  final CollectionReference _exercises =
  FirebaseFirestore.instance.collection('exercises/Dh84zosLMmjgRJkQYvWx/exercises/DWD92TbHIcNGz7uqdc12/sets');

  Map<String, dynamic>? additionalData;

  Future<String?> handleTag(NfcTag tag) async {
    tags.add(tag);
    additionalData = {};

    notifyListeners();
    return 'Exercise added to workout.';
  }
}

class TagReadPage extends StatelessWidget {
  const TagReadPage({super.key});

  static Widget withDependency() => ChangeNotifierProvider<TagReadModel>(
    create: (_) => TagReadModel(),
    child: const TagReadPage(),
  );

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<TagReadModel>(
      create: (_) => TagReadModel(),
      builder: (context, child) {
        return Expanded(
          child: Scaffold(
            body: Builder(
              builder: (BuildContext newContext) {
                return ListView(
                  padding: const EdgeInsets.all(2),
                  children: [
                    FormSection(
                      children: [
                        FormRow(
                          title: const Text('Add Exercise'),
                          onTap: () => startSession(
                            context: context,
                            handleTag:
                            Provider.of<TagReadModel>(context, listen: false)
                                .handleTag,
                          ),
                        ),
                      ],
                    ),
                    Consumer<TagReadModel>(builder: (context, model, _) {
                      final tags = model.tags;
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tags.length,
                        itemBuilder: (context, index) {
                          final tag = tags[index];
                          return _TagInfo(tag);
                        },
                      );
                    }),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(30, 215, 96, 1),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/workoutlog');
                        },
                        child: const Text('Finish Workout'))
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _TagInfo extends StatelessWidget {
  const _TagInfo(this.tag);

  final NfcTag tag;

  @override
  Widget build(BuildContext context) {
    final ndefWidgets = <Widget>[];

    Object? tech;

    tech = Ndef.from(tag);
    if (tech is Ndef) {
      final cachedMessage = tech.cachedMessage;
      final type = tech.additionalData['type'] as String?;
      if (type != null) {}
      if (cachedMessage != null) {
        for (var i in Iterable.generate(cachedMessage.records.length)) {
          final record = cachedMessage.records[i];
          final info = NdefRecordInfo.fromNdef(record);
          ndefWidgets.add(FormRow(
              title: Text(info.subtitle.replaceAll(('(en) '), '')),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => NdefRecordPage(i, record),
            )),
          ));
        }
      }
    }

    return Column(
      children: [
        if (ndefWidgets.isNotEmpty)
          FormSection(
            header: const SizedBox(height: 20),
            children: ndefWidgets,
          ),
      ],
    );
  }
}