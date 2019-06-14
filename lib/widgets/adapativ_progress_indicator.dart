import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdapativProgressIndicator extends StatelessWidget {
  final Color color;
  AdapativProgressIndicator({this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Center(
            child: Theme.of(context).platform == TargetPlatform.android
            ? CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    color == null ? Theme.of(context).primaryColor : color))
            : CupertinoActivityIndicator(),
      ),
    );
  }
}
