import 'package:cloud_firestore/cloud_firestore.dart';

import 'dorama.dart';

class Memo {
  String d_id;
  String title;
  String content;
  int c_id;
  int created_at;
  int updated_at;
  String documentId;
  Future<Dorama> dorama;

  Memo({
    this.d_id,
    this.title,
    this.content,
    this.c_id,
    this.created_at,
    this.documentId,
    this.dorama,
  });

  Map<String, dynamic> toMap() {
    return {
      'd_id': this.d_id,
      'title': this.title,
      'content': this.content,
      'c_id': this.c_id,
      'created_at': this.created_at,
    };
  }

  static Memo fromMap(DocumentSnapshot map) {
    if (map == null) return null;

    return Memo(
      title: map['title'],
      content: map['content'].replaceAll('<br/>', '\n'),
      c_id: map['c_id'],
      d_id: map['d_id'],
      created_at: map['created_at'],
      documentId: map.documentID,
    );
  }
}
