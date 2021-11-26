import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/memo.dart';
import '../../viewmodels/memo_view_model.dart';

class MemoDeleteDialog extends StatelessWidget {
  final Memo memo;
  final VoidCallback returnAction;

  const MemoDeleteDialog({
    Key key,
    Memo this.memo,
    VoidCallback this.returnAction,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('メモの削除'),
      contentPadding: EdgeInsets.all(16),
      children: <Widget>[
        Text('本当に削除しても宜しいですか？'),
        FlatButton(
          child: Text(
            '削除',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.blue,
          onPressed: () {
            final viewModel =
                Provider.of<MemoViewModel>(context, listen: false);
            viewModel.delete(memo);
            this.returnAction();
          },
        )
      ],
    );
  }
}
