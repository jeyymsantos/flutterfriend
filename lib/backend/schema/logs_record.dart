import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LogsRecord extends FirestoreRecord {
  LogsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "generated_on" field.
  DateTime? _generatedOn;
  DateTime? get generatedOn => _generatedOn;
  bool hasGeneratedOn() => _generatedOn != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  void _initializeFields() {
    _text = snapshotData['text'] as String?;
    _generatedOn = snapshotData['generated_on'] as DateTime?;
    _type = snapshotData['type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('logs');

  static Stream<LogsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LogsRecord.fromSnapshot(s));

  static Future<LogsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LogsRecord.fromSnapshot(s));

  static LogsRecord fromSnapshot(DocumentSnapshot snapshot) => LogsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LogsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LogsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LogsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LogsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLogsRecordData({
  String? text,
  DateTime? generatedOn,
  String? type,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'text': text,
      'generated_on': generatedOn,
      'type': type,
    }.withoutNulls,
  );

  return firestoreData;
}

class LogsRecordDocumentEquality implements Equality<LogsRecord> {
  const LogsRecordDocumentEquality();

  @override
  bool equals(LogsRecord? e1, LogsRecord? e2) {
    return e1?.text == e2?.text &&
        e1?.generatedOn == e2?.generatedOn &&
        e1?.type == e2?.type;
  }

  @override
  int hash(LogsRecord? e) =>
      const ListEquality().hash([e?.text, e?.generatedOn, e?.type]);

  @override
  bool isValidKey(Object? o) => o is LogsRecord;
}
