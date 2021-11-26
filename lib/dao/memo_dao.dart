import '../model/memo.dart';
import '../service/firestore_service.dart';

class MemoDao {
  final dbProvider = FirestoreService();

  Future create(Memo memo) async {
    var result = dbProvider.createMemo(memo);
    return result;
  }

  Future fetchFirstMemoList() async {
    var result = dbProvider.fetchFirstMemoList();
    return result;
  }

  Future fetchNextMemoList() async {
    var result = dbProvider.fetchNextMemoList();
    return result;
  }

  Future fetchMemoListByDorama(String dId) async {
    var result = dbProvider.fetchMemoListByDorama(dId);
    return result;
  }

  Future deleteMemo(String documentId) async {
    dbProvider.deleteMemo(documentId);
  }

  Future updateMemo(Memo memo) async {
    dbProvider.updateMemo(memo);
  }

  Future fetchMemo(String documentId) async {
    dbProvider.fetchMemo(documentId);
  }
}
