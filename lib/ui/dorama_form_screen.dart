import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/core_constants.dart';
import '../model/dorama.dart';
import '../model/select_item.dart';
import '../viewmodels/dorama_view_model.dart';

class DoramaFormScreen extends StatelessWidget {
  static String id = 'dorama_form_screen';
  final _formkey = GlobalKey<FormState>();
  final Dorama editDorama;

  DoramaFormScreen({Key key, this.editDorama}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DoramaViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.all_inclusive,
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          _isEdit() ? 'ドラマを編集' : 'ドラマを追加',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: <Widget>[
          _buildForm(context, viewModel),
          _buildAddButton(context),
        ],
      ),
    );
  }

  Form _buildForm(BuildContext context, DoramaViewModel viewModel) {
    return Form(
      key: _formkey,
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
                    hintText: 'カテゴリー',
                    icon: Icon(Icons.category),
                  ),
                  //initialValue: '',
                  value: _isEdit()
                      ? DoramaCategoryItems.firstWhere(
                          (element) => element.id == editDorama.c_id)
                      : null,
                  onChanged: (value) {
                    viewModel.editingCategory = value;
                  },
                  items: DoramaCategoryItems.map((SelectItem value) {
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
                  'タイトル',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '作品名',
                    icon: Icon(Icons.bookmark_border),
                  ),
                  initialValue: _isEdit() ? editDorama.title : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'タイトルを入力して下さい。';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    viewModel.editingTitle = value;
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  bool _isEdit() {
    return editDorama != null;
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
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      final viewModel = Provider.of<DoramaViewModel>(context, listen: false);
      if (_isEdit()) {
        viewModel.update(editDorama);
      } else {
        viewModel.add();
      }
      Navigator.of(context).pop(true);
    }
  }
}
