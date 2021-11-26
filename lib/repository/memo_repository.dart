import '../dao/memo_dao.dart';
import '../model/memo.dart';

class MemoRepository {
  final memoDao = MemoDao();
  Future insertMemo(Memo memo) => memoDao.create(memo);
  Future getFistMemos() => memoDao.fetchFirstMemoList();
  Future getNextMemos() => memoDao.fetchNextMemoList();
  Future getMemosByDorama(String dId) => memoDao.fetchMemoListByDorama(dId);
  Future deleteMemo(String id) => memoDao.deleteMemo(id);
  Future updateMemo(Memo memo) => memoDao.updateMemo(memo);
  Future getMemo(String id) => memoDao.fetchMemo(id);
}
