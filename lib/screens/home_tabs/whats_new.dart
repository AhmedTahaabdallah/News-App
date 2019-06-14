import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhatsNew extends StatefulWidget {
  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  Widget _drawHeader(String image, String title, String description) {
    TextStyle _hederTitle = TextStyle(
        color: Colors.white, fontSize: 21.0, fontWeight: FontWeight.bold);
    TextStyle _hederDescrption = TextStyle(color: Colors.white, fontSize: 18.0);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .25,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage(image),
              fit: BoxFit.cover)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 75.0, right: 75.0),
              child: Text(
                title,
                style: _hederTitle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Text(
                description,
                style: _hederDescrption,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _drawTopStories() {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _drawSectionTitle('Top Stories'),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  _drawSingleRow('assets/images/placeholder_bg.png',
                   'The World Global Warming Annual Submit', 'Michael Adams', '15 Min'),
                  _drawDivider(),
                  _drawSingleRow('assets/images/placeholder_bg.png', 
                  'The World Global Warming Annual Submit','Michael Adams', '15 Min'),
                  _drawDivider(),
                  _drawSingleRow('assets/images/placeholder_bg.png',
                  'The World Global Warming Annual Submit', 'Michael Adams', '15 Min'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 16),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700),
      ),
    );
  }

  Widget _drawDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey.shade400,
    );
  }

  Widget _drawSingleRow(String image, String title, String auth, String time) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * .32,
            height: MediaQuery.of(context).size.height * .15,
            child: Image(
              image: ExactAssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(auth),
                    Row(
                      children: <Widget>[
                        Icon(Icons.timer,color: Colors.grey,), 
                        Text(time, style: TextStyle(color: Colors.grey),)],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _drawRecentUpdate() {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _drawSectionTitle('Recent Update'),
          Column(
            children: <Widget>[
              _drawRecentUpdateCard(Colors.deepOrange, 'assets/images/placeholder_bg.png', 'Vettel is Ferrail Number One', '15 Min'),
              _drawRecentUpdateCard(Colors.teal, 'assets/images/placeholder_bg.png', 'Vettel is Ferrail Number Two', '15 Min'),
              SizedBox(height: 15,)
            ],
          ),
        ],
      ),
    );
  }

  Widget _drawRecentUpdateCard(Color color, String image, String text, String time){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
          height: MediaQuery.of(context).size.height * .25,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(image),
                  fit: BoxFit.cover)),
            ),
            Container(
              padding: EdgeInsets.only(left: 24,right: 24,top: 2,bottom: 2),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Text('Sport', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
            ),
            Text(text,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),),
            SizedBox(height: 8.0,),
            Row(
              children: <Widget>[
                Icon(Icons.timer, color: Colors.grey,),
                Text(time,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500,color: Colors.grey),),
              ],
            )
          ],
        ),
      ),),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _drawHeader('assets/images/placeholder_bg.png', 
          'How Terriers & Royals Getecreshed Final', 
          'Lorem ipsum dolor sit amet, Royals Getecreshed Final'),
          _drawTopStories(),
          _drawRecentUpdate()
        ],
      ),
    );
  }

  
}
