import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/dorama.dart';
import '../model/memo.dart';
import '../ui/widget/main_bottom_navigation.dart';
import '../viewmodels/memo_view_model.dart';
import 'widget/memo_card.dart';

class MemoCardDetailScreen extends StatelessWidget {
  final Memo memo;

  const MemoCardDetailScreen({
    Key key,
    this.memo,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Provider.of<MemoViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.all_inclusive,
          color: Colors.black87,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: getTitle(memo.dorama),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: MemoCard(
          item: memo,
          returnAction: () => {
            Navigator.of(context).push<dynamic>(
              MaterialPageRoute<dynamic>(
                builder: (context) {
                  return MainBottomNavigation();
                },
              ),
            )
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.0),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
    );
  }

  Widget getTitle(Future<Dorama> dorama) {
    return FutureBuilder(
      future: dorama,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Text(
            snapshot.data.title,
            style: TextStyle(
              color: Colors.black,
            ),
          );
        } else {
          return Text(""); //空文字
        }
      },
    );
  }
}
