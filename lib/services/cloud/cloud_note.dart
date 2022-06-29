import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynotes/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudNote {
  final String documentId;
  final String ownerUserid;
  final String text;

  const CloudNote({
    required this.documentId,
    required this.ownerUserid,
    required this.text,
  });

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snap)
      : documentId = snap.id,
        ownerUserid = snap.data()[ownerUserIdFieldName],
        text = snap.data()[textFieldName] as String;
}
