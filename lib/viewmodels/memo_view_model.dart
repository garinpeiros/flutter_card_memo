import 'package:flutter/material.dart';

import '../constant/core_constants.dart';
import '../constant/ui_constants.dart';
import '../model/memo.dart';
import '../model/select_item.dart';
import '../repository/memo_repository.dart';

class MemoViewModel extends ChangeNotifier {
  static const int ItemRequestThreshold = LoadLimit;
  var editingCategory = SelectItem(
    0,
    '',
    '',
  );
  var editingTitle = '';
  var editingContent = '';
  List<Memo> get allMemoList => _allMemoList;
  List<Memo> _allMemoList = [];

  List<Memo> get slideMemoList => _slideMemoList;
  List<Memo> _slideMemoList = [];

  Memo get detailMemo => _detailMemo;
  Memo _detailMemo = null;

  int _currentPage = 0;
  final MemoRepository repo = MemoRepository();

  MemoViewModel() {
    _fetchAll();
  }

  void _fetchAll() async {
    _allMemoList = await repo.getFistMemos();
    notifyListeners();
  }

  void fetchAll() async {
    _allMemoList = await repo.getFistMemos();
  }

  void add(String dId) async {
    Memo memo = Memo(
      title: editingTitle,
      content: editingContent.replaceAll('\n', '<br/>'),
      c_id: editingCategory.id,
      d_id: dId,
      created_at: DateTime.now().millisecondsSinceEpoch,
    );
    repo.insertMemo(memo);
    _fetchAll();
    _resetPage();
    getSlideMemoList(dId);
    _resetCategory();
  }

  void update(Memo memo) {
    memo.title = editingTitle;
    memo.content = editingContent;

    if (editingCategory.id == 0) {
      editingCategory =
          CategoryItems.firstWhere((element) => element.id == memo.c_id);
    }
    memo.c_id = editingCategory.id;
    repo.updateMemo(memo);
    _fetchAll();
    _resetPage();
    _resetCategory();
  }

  void delete(Memo memo) {
    getSlideMemoList(memo.d_id);
    repo.deleteMemo(memo.documentId);
    _fetchAll();
    _resetPage();
  }

  void get(String documentId) async {
    _detailMemo = await repo.getMemo(documentId);
  }

  void _resetPage() {
    _currentPage = 0;
  }

  Future<List<Memo>> getSlideMemoList(String dId) async {
    _slideMemoList = await repo.getMemosByDorama(dId);
    notifyListeners();
  }

  Future handleItemCreated(int index) async {
    var itemPosition = index + 1;
    var requestMoreData =
        itemPosition % ItemRequestThreshold == 0 && itemPosition != 0;
    var pageToRequest = itemPosition ~/ ItemRequestThreshold;

    if (requestMoreData && pageToRequest > _currentPage) {
      _currentPage = pageToRequest;

      if (itemPosition % ItemRequestThreshold != 1) {
        _showLoadingIndicator();

        await Future.delayed(Duration(seconds: 2));
        var addMemoList = await repo.getNextMemos();

        if (addMemoList == false) {
          _removeLoadingIndicator();
        } else {
          _allMemoList = await _allMemoList + addMemoList;
          await notifyListeners();
          _removeLoadingIndicator();
        }
      }
    }

    if (itemPosition % ItemRequestThreshold == 0) {
      _removeLoadingIndicator();
    }
  }

  void _showLoadingIndicator() {
    _allMemoList.add(Memo(
      d_id: '1',
      title: LoadingIndicatorTitle,
      c_id: 1,
    ));
    notifyListeners();
  }

  void _removeLoadingIndicator() {
    _allMemoList
        .removeWhere((element) => element.title == LoadingIndicatorTitle);
    notifyListeners();
  }

  void _resetCategory() {
    editingCategory = SelectItem(
      0,
      '',
      '',
    );
  }
}
