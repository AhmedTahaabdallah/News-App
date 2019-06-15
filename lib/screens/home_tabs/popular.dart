import 'package:flutter/material.dart';
import '../../api/posts_api.dart';
//import 'dart:async';
import '../../models/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../widgets/adapativ_progress_indicator.dart';
import 'package:connectivity/connectivity.dart';
import '../../utillites/data_utillites.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  PostsApi postsApi = PostsApi();
  Widget _mainPage = AdapativProgressIndicator();

  void _checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        _mainPage = FutureBuilder(
          future: postsApi.fetchPostsByCategoriesId('3'),
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
                    return ListView.builder(
                      itemBuilder: (context, postion) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Card(
                            child: _drawSingleRow(posts[postion]),
                          ),
                        );
                      },
                      itemCount: posts.length,
                    );
                  } else {
                    return noData();
                  }
                }

                break;
            }
          },
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
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  post.title,
                  maxLines: 2,
                  textAlign: TextAlign.start,
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
                        children: <Widget>[
                          Icon(
                            Icons.timer,
                            color: Colors.grey,
                          ),
                          Text(
                            parseHumanDateTime(post.date_written),
                            style: TextStyle(color: Colors.grey),
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

  @override
  void initState() {
    _checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _mainPage;
  }
}
