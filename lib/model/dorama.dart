import 'package:cloud_firestore/cloud_firestore.dart';

class Dorama {
  String title;
  int c_id;
  int created_at;
  int updated_at;
  String documentId;

  Dorama({
    this.title,
    this.c_id,
    this.created_at,
    this.updated_at,
    this.documentId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'c_id': this.c_id,
      'created_at': this.created_at,
      'updated_at': this.updated_at,
    };
  }

  static Dorama fromMap(DocumentSnapshot map) {
    if (map == null) return null;

    return Dorama(
      title: map['title'],
      c_id: map['c_id'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
      documentId: map.documentID,
    );
  }
}
