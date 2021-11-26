import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/dorama.dart';
import '../model/memo.dart';
import '../viewmodels/memo_view_model.dart';
import 'memo_form_screen.dart';
import 'widget/memo_card.dart';

class MemoSlideScreen extends StatelessWidget {
  final Dorama dorama;

  MemoSlideScreen({
    Key key,
    this.dorama,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MemoViewModel>(context, listen: true);
    List<Widget> textSliders = [];
    List<Memo> memos = viewModel.slideMemoList;

    if (memos != null) {
      textSliders = memos
          .map(
            (item) => MemoCard(
              item: item,
              dorama: dorama,
              returnAction: () => {
                Navigator.of(context).push<dynamic>(
                  MaterialPageRoute<dynamic>(
                    builder: (context) {
                      return MemoSlideScreen(
                        dorama: dorama,
                      );
                    },
                  ),
                )
              },
            ),
          )
          .toList();
    }

    final double height = MediaQuery.of(context).size.height - 200;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.all_inclusive,
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          dorama.title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body:
          (memos.length > 0) ? CardSlideList(height, textSliders) : EmptyView(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          AddMemoButton(
            context,
            dorama,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          FloatingActionButton(
            heroTag: 'back',
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
            onPressed: () {
              /*
              Navigator.of(context).push<dynamic>(
                MaterialPageRoute<dynamic>(
                  builder: (context) {
                    return MainBottomNavigation();
                  },
                ),
              );
               */
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
  }

  Widget CardSlideList(double height, List<Widget> textSliders) {
    return Column(
      children: [
        Container(
          child: CarouselSlider(
            options: CarouselOptions(
              height: height,
              autoPlay: false,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: textSliders,
          ),
        ),
      ],
    );
  }

  Widget AddMemoButton(BuildContext context, Dorama dorama) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push<dynamic>(
          MaterialPageRoute<dynamic>(
            builder: (context) {
              return MemoFormScreen(
                editMemo: null,
                dorama: dorama,
              );
            },
          ),
        );
      },
    );
  }

  ///データがない場合
  Widget EmptyView() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        '「＋」ボタンをタップして\nこのドラマのカードを登録しましょう。',
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
