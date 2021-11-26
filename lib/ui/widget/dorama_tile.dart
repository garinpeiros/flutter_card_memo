import 'package:card_memo/constant/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/core_constants.dart';
import '../../model/dorama.dart';
import '../../util/util.dart';
import '../../viewmodels/memo_view_model.dart';
import '../dorama_form_screen.dart';
import '../memo_slide_screen.dart';
import 'dorama_delete_dialog.dart';

class DoramaTile extends StatelessWidget {
  final Dorama dorama;

  const DoramaTile({
    Key key,
    @required this.dorama,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.dorama.title == LoadingIndicatorTitle) {
      return _loadingCard();
    } else {
      return _card(context);
    }

    /*
    final viewModel = Provider.of<MemoViewModel>(context, listen: true);

    return Card(
      child: ListTile(
        leading: Chip(
          backgroundColor: Util().getColor(
            dorama.c_id,
            DoramaCategoryItems,
          ),
          label: Text(
            DoramaCategoryItems.firstWhere(
              (element) => element.id == dorama.c_id,
            ).name,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        onTap: () async {
          var result = await showMenu(
            context: context,
            position: _getPosition(context),
            items: <PopupMenuItem<String>>[
              const PopupMenuItem<String>(child: Text('カード一覧'), value: 'card'),
              const PopupMenuItem<String>(child: Text('編集'), value: 'edit'),
              const PopupMenuItem<String>(child: Text('削除'), value: 'delete'),
            ],
            elevation: 8.0,
          );
          if (result == 'edit') {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return DoramaFormScreen(
                    editDorama: dorama,
                  );
                },
              ),
            );
          } else if (result == 'delete') {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DoramaDeleteDialog(
                  dorama: dorama,
                  returnAction: () => {Navigator.of(context).pop(true)},
                );
              },
            );
          } else if (result == 'card') {
            viewModel.getSlideMemoList(dorama.documentId);
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return MemoSlideScreen(
                    dorama: dorama,
                  );
                },
              ),
            );
          }
        },
        trailing: Icon(Icons.more_horiz),
        title: Text(dorama.title),
      ),
    );
     */
  }

  Widget _card(BuildContext context) {
    final viewModel = Provider.of<MemoViewModel>(context, listen: true);
    return Card(
      child: ListTile(
        leading: Chip(
          backgroundColor: Util().getColor(
            dorama.c_id,
            DoramaCategoryItems,
          ),
          label: Text(
            DoramaCategoryItems.firstWhere(
              (element) => element.id == dorama.c_id,
            ).name,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        onTap: () async {
          var result = await showMenu(
            context: context,
            position: _getPosition(context),
            items: <PopupMenuItem<String>>[
              const PopupMenuItem<String>(child: Text('カード一覧'), value: 'card'),
              const PopupMenuItem<String>(child: Text('編集'), value: 'edit'),
              const PopupMenuItem<String>(child: Text('削除'), value: 'delete'),
            ],
            elevation: 8.0,
          );
          if (result == 'edit') {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return DoramaFormScreen(
                    editDorama: dorama,
                  );
                },
              ),
            );
          } else if (result == 'delete') {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DoramaDeleteDialog(
                  dorama: dorama,
                  returnAction: () => {Navigator.of(context).pop(true)},
                );
              },
            );
          } else if (result == 'card') {
            viewModel.getSlideMemoList(dorama.documentId);
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return MemoSlideScreen(
                    dorama: dorama,
                  );
                },
              ),
            );
          }
        },
        trailing: Icon(Icons.more_horiz),
        title: Text(dorama.title),
      ),
    );
  }

  Widget _loadingCard() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 55,
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: FractionalOffset.topLeft,
              child: Text("Loading..."),
            ),
          ),
        ],
      ),
    );
  }

  RelativeRect _getPosition(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset topLeft = box.size.topLeft(box.localToGlobal(Offset.zero));
    /*
    final Offset bottomRight =
        box.size.bottomRight(box.localToGlobal(Offset.zero));
    */
    return RelativeRect.fromLTRB(100, topLeft.dy, 0, 0);
  }
}
