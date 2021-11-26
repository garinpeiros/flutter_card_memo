import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../constant/core_constants.dart';
import '../model/dorama.dart';
import '../model/memo.dart';

class FirestoreService {
  static int limit = LoadLimit;

  final CollectionReference _memosCollectionReference =
      Firestore.instance.collection('memos');

  final CollectionReference _doramasCollectionReference =
      Firestore.instance.collection('doramas');

  DocumentSnapshot _memoLastData = null;
  DocumentSnapshot _doramaLastData = null;

  ///
  /// メモ関連
  ///
  Future createMemo(Memo memo) async {
    try {
      await _memosCollectionReference
          .document(memo.documentId)
          .setData(memo.toMap());
      return true;
    } catch (e) {
      if (e is PlatformException) {
        print(e.message);
      }
      print(e.toString());
      return false;
    }
  }

  Future<Dorama> _getDorama(String dId) async {
    try {
      DocumentSnapshot result =
          await _doramasCollectionReference.document(dId).get();

      Dorama data = Dorama.fromMap(result);
      return data;
    } catch (e) {
      if (e is PlatformException) {
        print(e.message);
      }
      print(e.toString());
      return Dorama();
    }
  }

  Future fetchFirstMemoList() async {
    try {
      List<DocumentSnapshot> result = (await _memosCollectionReference
              .orderBy("created_at", descending: true)
              .limit(limit)
              .getDocuments())
          .documents;

      _memoLastData = result[result.length - 1];

      List<Memo> memos = await result.isNotEmpty
          ? result.map((item) => Memo.fromMap(item)).toList()
          : [];

      await memos.forEach((memo) async {
        Future<Dorama> dorama = _getDorama(memo.d_id);
        memo.dorama = dorama;
      });

      return memos;
    } catch (e) {
      if (e is PlatformException) {
        print(e.message);
      }
      print(e.toString());
      return List<Memo>();
    }
  }

  Future fetchNextMemoList() async {
    try {
      List<DocumentSnapshot> result = (await _memosCollectionReference
              .startAfterDocument(_memoLastData)
              .orderBy("created_at", descending: true)
              .limit(limit)
              .getDocuments())
          .documents;

      _memoLastData = result[result.length - 1];

      List<Memo> memos = await result.isNotEmpty
          ? result.map((item) => Memo.fromMap(item)).toList()
          : [];

      await memos.forEach((memo) async {
        Future<Dorama> dorama = _getDorama(memo.d_id);
        memo.dorama = dorama;
      });

      return memos;
    } catch (e) {
      if (e is PlatformException) {
        print(e.message);
      }
      print(e.toString());
      return List<Memo>();
    }
  }

  Future fetchMemoListByDorama(String dId) async {
    try {
      List<DocumentSnapshot> result = (await _memosCollectionReference
              .where('d_id', isEqualTo: dId)
              .orderBy("created_at", descending: true)
              .getDocuments())
          .documents;

      List<Memo> memos = result.isNotEmpty
          ? result.map((item) => Memo.fromMap(item)).toList()
          : [];

      return memos;
    } catch (e) {
      if (e is PlatformException) {
        print(e.message);
      }
      print(e.toString());
      return List<Memo>();
    }
  }

  Future updateMemo(Memo memo) async {
    try {
      await _memosCollectionReference
          .document(memo.documentId)
          .updateData(memo.toMap());
    } catch (e) {
      if (e is PlatformException) {
        print(e.message);
        return false;
      }
      print(e.toString());
      return false;
    }
  }

  Future deleteMemo(String documentId) async {
    await _memosCollectionReference.document(documentId).delete();
  }

  Future fetchMemo(String documentId) async {
    var memo = await _memosCollectionReference.document(documentId).get();
    return Memo.fromMap(memo);
  }

  ///
  /// ドラマ関連
  ///
  Future<bool> createDorama(Dorama dorama) async {
    try {
      await _doramasCollectionReference
          .document(dorama.documentId)
          .setData(dorama.toMap());
      return true;
    } catch (e) {
      if (e is PlatformException) {
        print(e.message);
      }
      print(e.toString());
      return false;
    }
  }

  Future<List<Dorama>> fetchFirstDoramaList() async {
    try {
      List<DocumentSnapshot> result = (await _doramasCollectionReference
              .orderBy("created_at", descending: true)
              .limit(limit)
              .getDocuments())
          .documents;

      _doramaLastData = result[result.length - 1];

      List<Dorama> doramas = result.isNotEmpty
          ? result.map((item) => Dorama.fromMap(item)).toList()
          : [];

      return doramas;
    } catch (e) {
      if (e is PlatformException) {
        print(e.message);
      }
      print(e.toString());
      return List<Dorama>();
    }
  }

  Future<List<Dorama>> fetchNextDoramaList() async {
    try {
      List<DocumentSnapshot> result = (await _doramasCollectionReference
              .startAfterDocument(_doramaLastData)
              .orderBy("created_at", descending: true)
              .limit(limit)
              .getDocuments())
          .documents;

      _doramaLastData = result[result.length - 1];

      List<Dorama> doramas = result.isNotEmpty
          ? result.map((item) => Dorama.fromMap(item)).toList()
          : [];

      return doramas;
    } catch (e) {
      if (e is PlatformException) {
        print(e.message);
      }
      print(e.toString());
      return List<Dorama>();
    }
  }

  Future<bool> updateDorama(Dorama dorama) async {
    try {
      await _doramasCollectionReference
          .document(dorama.documentId)
          .updateData(dorama.toMap());
    } catch (e) {
      if (e is PlatformException) {
        print(e.message);
        return false;
      }
      print(e.toString());
      return false;
    }
  }

  Future deleteDorama(String documentId) async {
    await _doramasCollectionReference.document(documentId).delete();
  }
}
