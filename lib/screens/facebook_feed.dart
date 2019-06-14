import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../shared_ui/navigation_drawer.dart';

class FaceBookFeed extends StatefulWidget {
  @override
  _FaceBookFeedState createState() => _FaceBookFeedState();
}

class _FaceBookFeedState extends State<FaceBookFeed> {
  //TextStyle _hashTagStyle = TextStyle(color: Colors.orange);
  Widget _cardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 12,
                right: 16,
                left: 16,
              ),
              child: CircleAvatar(
                radius: 24,
                backgroundImage: ExactAssetImage(
                  'assets/images/placeholder_bg.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Christina Meyers',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Fri, 12 May 2017  14:34',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 4,
            top: 12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.favorite,
                ),
                onPressed: () {},
                color: Colors.grey.shade400,
              ),
              Transform.translate(
                offset: Offset(-10, 0),
                child: Text(
                  '25',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _cardBody() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          top: 16,
          right: 16,
          left: 16,
          bottom: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'We Also Talk About Future of Work as the Reboots advance, and we ask whether a retro phone',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                //fontWeight: FontWeight.w400,
                height: 1.2,
                color: Colors.grey.shade900,
              ),
            ),
            Wrap(
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    '#advance',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    '#advance',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    '#advance',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .30,
                child: Image(
                  image: ExactAssetImage(
                    'assets/images/bg3.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardFooter() {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        top: 0,
        bottom: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              
              Text(
                '10 COMMENTS',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text(
                  'Share',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 16,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  'Open',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook Feeds'),
        centerTitle: false,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          )
        ],
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.only(
          top: 8,
          right: 8,
          left: 8,
        ),
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
            ),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[_cardHeader(), _cardBody(), _cardFooter()],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }
}
