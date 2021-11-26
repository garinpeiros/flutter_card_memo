import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/core_constants.dart';
import '../../model/dorama.dart';
import '../../model/memo.dart';
import '../../ui/memo_form_screen.dart';
import '../../ui/widget/memo_delete_dialog.dart';
import '../../util/util.dart';

class MemoCard extends StatelessWidget {
  final Memo item;
  final Dorama dorama;
  final VoidCallback returnAction;

  const MemoCard({
    Key key,
    @required this.item,
    this.dorama,
    this.returnAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: Stack(
            children: <Widget>[
              Container(
                height: 500,
                padding: EdgeInsets.only(
                    top: 50.0, right: 0.0, bottom: 0.0, left: 0.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(30.0),
                        child: Text(
                          this.item.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 0.0, right: 20.0, bottom: 20.0, left: 20.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              //                    <--- top side
                              color: Colors.black38,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 0.0, right: 20.0, bottom: 0.0, left: 20.0),
                        child: Text(
                          this.item.content.replaceAll("<br/>", "\n"),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Util().getColor(item.c_id, CategoryItems)
                      /*
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 0, 0, 0),
                          Color.fromARGB(255, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                       */
                      ),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text(
                              CategoryItems.firstWhere(
                                  (element) => element.id == item.c_id).name,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return MemoDeleteDialog(
                                      memo: item,
                                      returnAction: returnAction,
                                      /*
                                          () => {
                                        Navigator.of(context).push<dynamic>(
                                          MaterialPageRoute<dynamic>(
                                            builder: (context) {
                                              return MainBottomNavigation();
                                            },
                                          ),
                                        )
                                      },*/
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => {
                                Navigator.of(context).push<dynamic>(
                                  MaterialPageRoute<dynamic>(
                                    builder: (context) {
                                      return MemoFormScreen(
                                        editMemo: item,
                                        dorama: dorama,
                                      );
                                    },
                                  ),
                                )
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
