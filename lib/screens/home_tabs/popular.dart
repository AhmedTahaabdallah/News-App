import 'package:flutter/material.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {

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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, postion){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Card(
                child: _drawSingleRow('assets/images/placeholder_bg.png',
                       'The World Global Warming Annual Submit', 'Michael Adams', '15 Min'),
        ),
      );
    },itemCount: 20,);
  }
}