import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/core_constants.dart';
import '../model/dorama.dart';
import '../model/memo.dart';
import '../model/select_item.dart';
import '../viewmodels/memo_view_model.dart';

class MemoFormScreen extends StatelessWidget {
  static String id = "memo_form_screen";
  final _formKey = GlobalKey<FormState>();
  final Memo editMemo;
  final Dorama dorama;

  MemoFormScreen({
    Key key,
    this.editMemo,
    this.dorama,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MemoViewModel>(context, listen: false);
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
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: <Widget>[
          _buildForm(context, viewModel),
          _buildAddButton(context)
        ],
      ),
    );
  }

  Form _buildForm(BuildContext context, MemoViewModel viewModel) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'カテゴリー',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.category),
                  ),
                  //initialValue: '',
                  value: _isEdit()
                      ? CategoryItems.firstWhere(
                          (element) => element.id == editMemo.c_id)
                      : null,
                  onChanged: (value) {
                    viewModel.editingCategory = value;
                  },
                  items: CategoryItems.map((SelectItem value) {
                    return DropdownMenuItem<SelectItem>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'カテゴリーを選択してください。';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'メモ',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '内容を簡潔に',
                    icon: Icon(Icons.note),
                  ),
                  initialValue: _isEdit() ? editMemo.title : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'メモを入力して下さい。';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    viewModel.editingTitle = value;
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '補足',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '詳細な情報を記載',
                    icon: Icon(Icons.playlist_add),
                  ),
                  maxLines: null,
                  minLines: 10,
                  initialValue: _isEdit() ? editMemo.content : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return '補足内容を入力して下さい。';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    viewModel.editingContent = value;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isEdit() {
    return editMemo != null;
  }

  Widget _getTitle(Dorama dorama) {
    String title = '';
    if (dorama != null) {
      title =
          _isEdit() ? '「${dorama.title}」のカードを編集' : '「${dorama.title}」のカードを追加';
    }
    return Text(title);
  }

  Widget _buildAddButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: RawMaterialButton(
        onPressed: () => tapAddButton(context),
        elevation: 2.0,
        fillColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.check,
          size: 35.0,
          color: Colors.white,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
    );
  }

  tapAddButton(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final viewModel = Provider.of<MemoViewModel>(context, listen: false);
      if (_isEdit()) {
        viewModel.update(editMemo);
      } else {
        viewModel.add(dorama.documentId);
      }
      Navigator.of(context).pop(true);
    }
  }
}
