import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../api/posts_api.dart';
//import 'dart:async';
import '../../models/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../widgets/adapativ_progress_indicator.dart';
import 'package:connectivity/connectivity.dart';
import '../../utillites/data_utillites.dart';

class WhatsNew extends StatefulWidget {
  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  PostsApi postsApi = PostsApi();
  Widget _mainPage = AdapativProgressIndicator();

  void _checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
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
      });
    } else {
      setState(() {
        _mainPage = Container(
          child: Center(
            child: Text(
              'No Internet Connection!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      });
    }
  }

  Widget _drawHeader(String image, String title, String description) {
    TextStyle _hederTitle = TextStyle(
        color: Colors.white, fontSize: 21.0, fontWeight: FontWeight.bold);
    TextStyle _hederDescrption = TextStyle(color: Colors.white, fontSize: 18.0);

    return FutureBuilder(
      future: postsApi.fetchPostsByCategoriesId('1'),
      builder: (context, snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.waiting:
            return AdapativProgressIndicator();
            break;
          case ConnectionState.active:
            return AdapativProgressIndicator();
            break;
          case ConnectionState.none:
            return connectionError();
            break;
          case ConnectionState.done:
            if (snapShot.hasError) {
              return error(snapShot.error);
            } else {
              if (snapShot.hasData) {
                List<Post> posts = snapShot.data;
                Random random = Random();
                int randomIndex = random.nextInt(posts.length);
                Post post = posts[randomIndex];
                return Stack(
                  children: <Widget>[
                    Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .25,
                  /*decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage(image), fit: BoxFit.cover)),*/
                  child: CachedNetworkImage(
              imageUrl: post.featured_image,
              placeholder: (context, url) => AdapativProgressIndicator(),
              errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.shade300,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.error,
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                  ),
              fit: BoxFit.cover,
            ),),
                   Center(
                       child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 75.0, right: 75.0),
                            child: Text(
                              post.title,
                              style: _hederTitle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Text(
                              post.content.substring(0, 70) + '...',
                              style: _hederDescrption,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                  ),
                     ),
                
                  ],
                );
                /*return Container(
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
                          padding:
                              const EdgeInsets.only(left: 75.0, right: 75.0),
                          child: Text(
                            post.title,
                            style: _hederTitle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text(
                            post.content,
                            style: _hederDescrption,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                );*/
              } else {
                return noData();
              }
            }

            break;
        }
      },
    );
  }

  List<Widget> _topStoriesItemList(List<Post> postss) {
    List<Widget> _wideget = List<Widget>();
    int lenthg = 3;
    if (postss.length == 1) {
      lenthg = 1;
    } else if (postss.length == 2) {
      lenthg = 2;
    } else if (postss.length == 3) {
      lenthg = 3;
    }
    for (int i = 1; i <= lenthg; i++) {
      _wideget.add(_drawSingleRow(postss[i - 1]));
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
                future: postsApi.fetchPostsByCategoriesId('1'),
                builder: (context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return AdapativProgressIndicator();
                      break;
                    case ConnectionState.active:
                      return AdapativProgressIndicator();
                      break;
                    case ConnectionState.none:
                      return connectionError();
                      break;
                    case ConnectionState.done:
                      if (snapshot.error != null) {
                        return error(snapshot.error);
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
                          return noData();
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
              errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.shade300,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.error,
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                  ),
              fit: BoxFit.cover,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  post.title,
                  textAlign: TextAlign.start,
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
                        child: SizedBox(
                          width: 5.0,
                        )),
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
                          SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 4,
                            child: Text(
                              parseHumanDateTime(post.date_written),
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

  List<Widget> _recentUpdateItemList(List<Post> postss) {
    List<Widget> _wideget = List<Widget>();
    int lenthg = 2;
    if (postss.length == 1) {
      lenthg = 1;
    } else if (postss.length == 2) {
      lenthg = 2;
    }
    for (int i = 1; i <= lenthg; i++) {
      if (i == 1) {
        _wideget.add(_drawRecentUpdateCard(postss[i - 1], Colors.deepOrange));
      } else {
        _wideget.add(_drawRecentUpdateCard(postss[i - 1], Colors.teal));
      }
    }
    _wideget.add(SizedBox(
      height: 15,
    ));
    return _wideget;
  }

  Widget _drawRecentUpdate() {
    return Container(
      color: Colors.grey.shade100,
      child: FutureBuilder(
        future: postsApi.fetchPostsByCategoriesId('2'),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return AdapativProgressIndicator();
              break;
            case ConnectionState.active:
              return AdapativProgressIndicator();
              break;
            case ConnectionState.none:
              return connectionError();
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return error(snapshot.error);
              } else {
                if (snapshot.hasData) {
                  List<Post> posts = snapshot.data;
                  //if (posts.length >= 3) {
                  return Column(
                    children: _recentUpdateItemList(posts),
                  );
                } else {
                  return noData();
                }
              }

              break;
          }
        },
      ),
    );
  }

  Widget _drawRecentUpdateCard(Post posts, Color color) {
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
                child: CachedNetworkImage(
                  imageUrl: posts.featured_image,
                  placeholder: (context, url) => AdapativProgressIndicator(),
                  errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.shade300,
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.error,
                          color: Theme.of(context).primaryColor,
                          size: 40,
                        ),
                      ),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 24, right: 24, top: 2, bottom: 2),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(4)),
                child: Text(
                  posts.categoryTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                posts.title,
                textAlign: TextAlign.start,
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
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    parseHumanDateTime(posts.date_written),
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
    return _mainPage;
    /*return SingleChildScrollView(
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
    );*/
  }
}
