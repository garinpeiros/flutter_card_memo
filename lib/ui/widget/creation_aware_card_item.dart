import 'package:flutter/material.dart';

class CreationAwareCardItem extends StatefulWidget {
  final Function itemCreated;
  final Widget child;

  const CreationAwareCardItem({
    Key key,
    this.itemCreated,
    this.child,
  }) : super(key: key);

  @override
  _CreationAwareCardItemState createState() => _CreationAwareCardItemState();
}

class _CreationAwareCardItemState extends State<CreationAwareCardItem> {
  @override
  void initState() {
    super.initState();
    if (widget.itemCreated != null) {
      widget.itemCreated();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
