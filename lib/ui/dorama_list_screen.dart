import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../ui/widget/dorama_tile.dart';
import '../viewmodels/dorama_view_model.dart';
import 'dorama_form_screen.dart';
import 'widget/creation_aware_card_item.dart';

class DoramaListScreen extends StatelessWidget {
  DoramaListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DoramaViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.all_inclusive,
          color: Colors.black87,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'ドラマ一覧',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: (viewModel.allDoramaList.length > 0)
          ? DoramaList(viewModel)
          : EmptyView(),
      floatingActionButton: AddDoramaButton(),
    );
  }

  Widget DoramaList(DoramaViewModel viewModel) {
    return ListView.builder(
      itemCount: (viewModel.allDoramaList != null)
          ? viewModel.allDoramaList.length
          : 0,
      itemBuilder: (context, index) => CreationAwareCardItem(
        itemCreated: () {
          SchedulerBinding.instance.addPostFrameCallback(
            (duration) => viewModel.handleItemCreated(index),
          );
        },
        child: DoramaTile(dorama: viewModel.allDoramaList[index]),
      ),
    );
  }

  Widget EmptyView() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        '「＋」ボタンをタップしてドラマを登録しましょう。',
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}

class AddDoramaButton extends StatelessWidget {
  const AddDoramaButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, DoramaFormScreen.id);
      },
    );
  }
}
