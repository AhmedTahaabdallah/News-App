import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCircleAvatar extends StatelessWidget {
  final int animationDuration;
  final double radius;
  final String imagePath;
  final double mySize;

  const CustomCircleAvatar(
      {Key key,
      this.animationDuration,
      this.radius,
      this.imagePath,
      this.mySize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AnimatedContainer(
      duration: new Duration(
        milliseconds: animationDuration,
      ),
      constraints: new BoxConstraints(
        minHeight: radius,
        maxHeight: radius,
        minWidth: radius,
        maxWidth: radius,
      ),
      child: new ClipOval(
        child: new CachedNetworkImage(
            errorWidget: (context, url, error) => Center(
                  child: Text('error',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: mySize)),
                ),
            fit: BoxFit.cover,
            imageUrl: imagePath,
            placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
            alignment: Alignment.center),
      ),
    );
  }
}
