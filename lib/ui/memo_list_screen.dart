import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../model/memo.dart';
import '../ui/memo_card_detail_screen.dart';
import '../ui/widget/creation_aware_card_item.dart';
import '../ui/widget/memo_card_tile.dart';
import '../viewmodels/memo_view_model.dart';

class MemoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MemoViewModel>(context, listen: true);
    //viewModel.fetchAll();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.all_inclusive,
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'カード一覧',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: (viewModel.allMemoList.length > 0)
          ? CardList(viewModel)
          : EmptyView(),
    );
  }

  ///カード一覧
  Widget CardList(MemoViewModel viewModel) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount:
          (viewModel.allMemoList != null) ? viewModel.allMemoList.length : 0,
      itemBuilder: (context, index) => CreationAwareCardItem(
        itemCreated: () {
          SchedulerBinding.instance.addPostFrameCallback(
            (duration) => viewModel.handleItemCreated(index),
          );
        },
        child: MemoCardTile(
          memo: (viewModel.allMemoList[index] != null)
              ? viewModel.allMemoList[index]
              : '',
          onTap: () {
            Navigator.of(context).push<dynamic>(
              MaterialPageRoute<dynamic>(
                builder: (context) {
                  var memo = Memo();
                  if (viewModel.allMemoList[index] != null) {
                    memo = viewModel.allMemoList[index];
                  }
                  return MemoCardDetailScreen(
                    memo: memo,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  ///データがない場合
  Widget EmptyView() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        'ドラマ一覧からカード一覧に遷移して、ドラマごとのカードを登録しましょう。\n\n\nドラマを登録してない場合は、まずドラマを登録しましょう。',
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
