import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/dorama.dart';
import '../../viewmodels/dorama_view_model.dart';

class DoramaDeleteDialog extends StatelessWidget {
  final Dorama dorama;
  final VoidCallback returnAction;

  const DoramaDeleteDialog({
    Key key,
    Dorama this.dorama,
    VoidCallback this.returnAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('ドラマの削除'),
      contentPadding: EdgeInsets.all(16),
      children: <Widget>[
        Text('本当に削除しても宜しいでしょうか？'),
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
                Provider.of<DoramaViewModel>(context, listen: false);
            viewModel.delete(dorama);
            this.returnAction();
          },
        ),
      ],
    );
  }
}
