import 'package:flutter/material.dart';

import '../constant/core_constants.dart';
import '../constant/ui_constants.dart';
import '../model/dorama.dart';
import '../model/select_item.dart';
import '../repository/dorama_repository.dart';

class DoramaViewModel extends ChangeNotifier {
  static const int ItemRequestThreshold = LoadLimit;

  var editingTitle = '';
  var editingCategory = SelectItem(
    0,
    '',
    '',
  );
  List<Dorama> get allDoramaList => _allDoramaList;
  List<Dorama> _allDoramaList = [];
  int _currentPage = 0;
  final DoramaRepository repo = DoramaRepository();

  DoramaViewModel() {
    _fetchAll();
  }

  void _fetchAll() async {
    _allDoramaList = await repo.fetchFirst();
    notifyListeners();
  }

  void add() async {
    Dorama dorama = Dorama(
      title: editingTitle,
      c_id: editingCategory.id,
      created_at: DateTime.now().millisecondsSinceEpoch,
      updated_at: DateTime.now().millisecondsSinceEpoch,
    );
    repo.insert(dorama);
    _fetchAll();
    _resetPage();
    _resetCategory();
  }

  void update(Dorama dorama) {
    dorama.title = editingTitle;
    if (editingCategory.id == 0) {
      editingCategory = DoramaCategoryItems.firstWhere(
          (element) => element.id == dorama.c_id);
    }
    dorama.c_id = editingCategory.id;
    repo.update(dorama);
    _fetchAll();
    _resetPage();
    _resetCategory();
  }

  void delete(Dorama dorama) {
    repo.delete(dorama.documentId);
    _fetchAll();
    _resetPage();
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

        await Future.delayed(Duration(seconds: 1));
        var addList = await repo.fetchNext();

        if (addList == false) {
          _removeLoadingIndicator();
        } else {
          _allDoramaList = _allDoramaList + addList;
          notifyListeners();
          _removeLoadingIndicator();
        }
      }
    }

    if (itemPosition % ItemRequestThreshold == 0) {
      _removeLoadingIndicator();
    }
  }

  void _showLoadingIndicator() {
    _allDoramaList.add(Dorama(
      title: LoadingIndicatorTitle,
    ));
    notifyListeners();
  }

  void _removeLoadingIndicator() {
    _allDoramaList
        .removeWhere((element) => element.title == LoadingIndicatorTitle);
    notifyListeners();
  }

  void _resetPage() {
    _currentPage = 0;
  }

  void _resetCategory() {
    editingCategory = SelectItem(
      0,
      '',
      '',
    );
  }
}
