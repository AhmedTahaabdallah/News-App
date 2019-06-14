import 'package:flutter/material.dart';
import '../shared_ui/navigation_drawer.dart';

class TwitterFeed extends StatefulWidget {
  @override
  _TwitterFeedState createState() => _TwitterFeedState();
}

class _TwitterFeedState extends State<TwitterFeed> {
  Widget _cardHeader() {
    return Row(
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
              Row(
                children: <Widget>[
                  Text(
                    'Christina Meyers',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '@ch_meyers',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
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
          bottom: 15,
        ),
        child: Text(
          'We Also Talk About Future of Work as the Reboots advance, and we ask whether a retro phone',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 18,
            //fontWeight: FontWeight.w400,
            height: 1.2,
            color: Colors.grey.shade900,
          ),
        ),
      ),
    );
  }

  Widget _cardFooter() {
    return Padding(
      padding: EdgeInsets.only(
        top: 0,
        bottom: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.repeat,
                  size: 28,
                ),
                color: Colors.orange,
                onPressed: () {},
              ),
              Text(
                '25',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.grey.shade700,
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
        title: Text('Twitter Feeds'),
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
                children: <Widget>[
                  _cardHeader(),
                  _cardBody(),
                  SizedBox(
                    width: double.infinity,
                    height: 1,
                    child: Container(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  _cardFooter()
                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }
}
