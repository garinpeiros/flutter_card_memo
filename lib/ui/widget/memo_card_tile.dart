import 'package:flutter/material.dart';

import '../../constant/core_constants.dart';
import '../../constant/ui_constants.dart';
import '../../model/dorama.dart';
import '../../model/memo.dart';
import '../../model/select_item.dart';
import '../../util/util.dart';

class MemoCardTile extends StatelessWidget {
  final Memo memo;
  final VoidCallback onTap;

  const MemoCardTile({
    Key key,
    this.memo,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: this.onTap,
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              color: Colors.grey[400],
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: this.memo.title == LoadingIndicatorTitle
            ? CircularProgressIndicator()
            : _card(memo),
        alignment: Alignment.center,
      ),
    );
  }

  Widget _card(Memo memo) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: FractionalOffset.topLeft,
                child: DefaultTextStyle(
                  style: new TextStyle(color: Colors.black),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  child: Text(
                    (memo.title != null) ? memo.title : '',
                    style: TextStyle(
                      color: Util().getColor(
                        memo.c_id,
                        CategoryItems,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 55,
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: FractionalOffset.topLeft,
              child: _getTitle(memo.dorama, memo.c_id),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: FractionalOffset.bottomRight,
              child: Text(
                Util().convertData(memo.created_at),
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: "NotoSerifJP-SemiBold",
                ),
              ),
            ),
          ),
        ],
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

  Widget _getTitle(Future<Dorama> dorama, int cId) {
    SelectItem category =
        CategoryItems.firstWhere((element) => element.id == cId);

    return FutureBuilder(
      future: dorama,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return RichText(
            text: TextSpan(
              text: snapshot.data.title ?? '',
              style: TextStyle(color: Colors.black, fontSize: 15),
              children: <TextSpan>[
                TextSpan(
                    text: ' / ${category.name}',
                    style: TextStyle(
                        color: Util().getColor(category.id, CategoryItems),
                        fontSize: 10)),
              ],
            ),
          );
        } else {
          return Text(""); //空文字
        }
      },
    );
  }
}
