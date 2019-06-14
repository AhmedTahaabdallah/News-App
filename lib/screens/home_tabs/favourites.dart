import 'dart:math';

import 'package:flutter/material.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<Color> colorsList = [
    Colors.red,
    Colors.teal,
    Colors.deepOrange,
    Colors.indigo,
    Colors.brown,
    Colors.purple,
    Colors.deepPurple,
    //Colors.yellow,
    Colors.green,
    //Colors.grey
  ];

  Random random = Random();

  Color _getRandomColor() {
    return colorsList[random.nextInt(colorsList.length)];
  }

  Widget _authorRow(
      String autherImage, String autherName, String time, String addit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(autherImage),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle),
              width: MediaQuery.of(context).size.width * .12,
              height: MediaQuery.of(context).size.height * .08,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  autherName,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      time,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      addit,
                      style: TextStyle(color: _getRandomColor()),
                    )
                  ],
                )
              ],
            )
          ],
        ),
        IconButton(
          icon: Icon(Icons.bookmark_border),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _newsItemRow(
    String newsImage,
    String newsTitle,
    String newsDescription,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10, top: 7, bottom: 10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage(newsImage), fit: BoxFit.cover)),
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.height * .15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  newsTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    newsDescription,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.25,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, postion) {
        return Padding(
          padding: const EdgeInsets.only(
            right: 4,
            left: 4,
          ),
          child: Card(
              child: Column(
            children: <Widget>[
              _authorRow(
                'assets/images/placeholder_bg.png',
                'Michael Adams',
                '15 Min',
                'Life Style',
              ),
              SizedBox(
                height: 12,
              ),
              _newsItemRow(
                'assets/images/bg3.png',
                'Tech Tent: Old Phones And Save Sociles',
                'We Also Talk About Future of Work as the Reboots advance, and we ask whether a retro phone',
              ),
            ],
          )),
        );
      },
      itemCount: 20,
    );
  }
}
