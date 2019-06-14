import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../api/posts_api.dart';
//import 'dart:async';
import '../../models/post.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import '../../widgets/adapativ_progress_indicator.dart';
import 'package:connectivity/connectivity.dart';

class WhatsNew extends StatefulWidget {
  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  PostsApi postsApi = PostsApi();
  Widget _mainPage = AdapativProgressIndicator();

  String _parseHumanDateTime(String dateTime) {
    Duration timeAgo = DateTime.now().difference(DateTime.parse(dateTime));
    DateTime theDiffrence = DateTime.now().subtract(timeAgo);
    return timeago.format(theDiffrence);
  }

  void _checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _mainPage = SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _drawHeader(
                'assets/images/placeholder_bg.png',
                'How Terriers & Royals Getecreshed Final',
                'Lorem ipsum dolor sit amet, Royals Getecreshed Final'),
            _drawTopStories(),
            _drawRecentUpdate()
          ],
        ),
      );
    } else {
      _mainPage = Container(
        child: Center(
          child: Text(
            'No Internet Connection!',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  Widget _error(var error) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
          child: Text(
        error.toString(),
        textAlign: TextAlign.center,
      )),
    );
  }

  Widget _noData() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
          child: Text(
        'No Data Available!',
        textAlign: TextAlign.center,
      )),
    );
  }

  Widget _connectionError() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
          child: Text(
        'Connection Error!',
        textAlign: TextAlign.center,
      )),
    );
  }

  Widget _drawHeader(String image, String title, String description) {
    TextStyle _hederTitle = TextStyle(
        color: Colors.white, fontSize: 21.0, fontWeight: FontWeight.bold);
    TextStyle _hederDescrption = TextStyle(color: Colors.white, fontSize: 18.0);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .25,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage(image), fit: BoxFit.cover)),
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

  List<Widget> _topStoriesItemList(List<Post> postss) {
    List<Widget> _wideget = List<Widget>();
    int lenthg = 3;
    if(postss.length == 1){
      lenthg = 1;
    } else if(postss.length == 2){
      lenthg = 2;
    } else if(postss.length == 3){
      lenthg = 3;
    } 
    for (int i = 1; i <= lenthg; i++) {
      _wideget.add(_drawSingleRow(postss[i-1]));
      if (i < lenthg) {
        _wideget.add(_drawDivider());
      }
    }
    return _wideget;
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
              child: FutureBuilder(
                future: postsApi.fetchWhatsNews(),
                builder: (context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return AdapativProgressIndicator();
                      break;
                    case ConnectionState.active:
                      return AdapativProgressIndicator();
                      break;
                    case ConnectionState.none:
                      return _connectionError();
                      break;
                    case ConnectionState.done:
                      if (snapshot.error != null) {
                        return _error(snapshot.error);
                      } else {
                        if (snapshot.hasData) {
                          List<Post> posts = snapshot.data;
                          //if (posts.length >= 3) {
                            return Column(
                              children: _topStoriesItemList(posts),
                            );
                          /*} else {
                            return _noData();
                          }*/
                          /*if (posts.length >= 3) {
                            return Column(                              
                              children: <Widget>[
                                _drawSingleRow(posts[0]),
                                _drawDivider(),
                                _drawSingleRow(posts[1]),
                                _drawDivider(),
                                _drawSingleRow(posts[2]),
                              ],
                            );
                          } else {
                            return _noData();
                          }*/
                        } else {
                          return _noData();
                        }
                      }

                      break;
                  }
                },
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

  Widget _drawSingleRow(Post post) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * .32,
            height: MediaQuery.of(context).size.height * .15,
            child: CachedNetworkImage(
              imageUrl: post.featured_image,
              placeholder: (context, url) => AdapativProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),

            /*Image.network(
              post.featured_image,
              fit: BoxFit.cover,
            ),*/
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  post.title,
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 4,
                        child: Text(post.autherName)),
                        Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: SizedBox(width: 5.0,)),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Icon(
                              Icons.timer,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 5.0,),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 4,
                            child: Text(
                              _parseHumanDateTime(post.date_written),
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
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
              _drawRecentUpdateCard(
                  Colors.deepOrange,
                  'assets/images/placeholder_bg.png',
                  'Vettel is Ferrail Number One',
                  '15 Min'),
              _drawRecentUpdateCard(
                  Colors.teal,
                  'assets/images/placeholder_bg.png',
                  'Vettel is Ferrail Number Two',
                  '15 Min'),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _drawRecentUpdateCard(
      Color color, String image, String text, String time) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage(image), fit: BoxFit.cover)),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 24, right: 24, top: 2, bottom: 2),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(4)),
                child: Text(
                  'Sport',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                text,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.timer,
                    color: Colors.grey,
                  ),
                  Text(
                    time,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //return _mainPage;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _drawHeader(
              'assets/images/placeholder_bg.png',
              'How Terriers & Royals Getecreshed Final',
              'Lorem ipsum dolor sit amet, Royals Getecreshed Final'),
          _drawTopStories(),
          _drawRecentUpdate()
        ],
      ),
    );
  }
}
