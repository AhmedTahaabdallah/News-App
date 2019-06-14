import 'package:flutter/material.dart';
import 'package:news_app/screens/home_screen.dart';
import '../pagemodel.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<PageModel> pages;
  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);

  void _addPages() {
    pages = List<PageModel>();
    //pages.clear();
    pages.add(
      PageModel(
        'Welcome!',
        'Making Friends is easy as waving your hand back and forth in easy step.',
        'assets/images/bg0.png',
        Icons.ac_unit,
      ),
    );
    pages.add(
      PageModel(
        'Images',
        'Making Images is easy as waving your hand back and forth in easy step.',
        'assets/images/bg1.png',
        Icons.add_to_photos,
      ),
    );
    pages.add(
      PageModel(
        'Videos',
        'Making Videos is easy as waving your hand back and forth in easy step.',
        'assets/images/bg2.png',
        Icons.airplay,
      ),
    );
    pages.add(
      PageModel(
        'Places',
        'Making Places is easy as waving your hand back and forth in easy step.',
        'assets/images/bg3.png',
        Icons.location_on,
      ),
    );
  }

  /*List<Widget> _drawPageIndicators(){
    List<Widget> _widgets = List<Widget>();
    for(var i in pages){
      _widgets.add(_drawCircle(Theme.of(context).primaryColor));
    }
    return _widgets;
  }

  Widget _drawCircle(Color color) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      width: 15.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor
      ),
    );
  }*/

  Widget _displayPageIndicator(int length) {
    return PageViewIndicator(
      pageIndexNotifier: _pageViewNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
            size: 8.0,
            color: Colors.white,
          ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
            scale: CurvedAnimation(
              parent: animationController,
              curve: Curves.ease,
            ),
            child: Circle(
              size: 12.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
    );
  }

  void _updateSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
  }

  @override
  Widget build(BuildContext context) {
    _addPages();
    //print(pages.length);
    double ww = MediaQuery.of(context).size.width;
    double myWidth = MediaQuery.of(context).orientation == Orientation.portrait
        ? ww * .05
        : ww * .15;
    return Stack(
      children: <Widget>[
        Scaffold(
          body: PageView.builder(
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(pages[index].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Transform.translate(
                        child: Icon(
                          pages[index].icon,
                          size: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 150.0
                              : 100.0,
                          color: Colors.white,
                        ),
                        offset: Offset(
                            0,
                            MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? -100
                                : -40),
                      ),
                      Transform.translate(
                        child: Text(
                          pages[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        offset: Offset(
                            0,
                            MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? -50
                                : -20),
                      ),
                      Transform.translate(
                        child: Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * .05,
                                left: MediaQuery.of(context).size.width * .05,
                                top: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 18.0
                                    : 10.0),
                            child: Text(
                              pages[index].description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20.0,
                              ),
                            )),
                        offset: Offset(
                            0,
                            MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? -50
                                : -20),
                      )
                    ],
                  )
                ],
              );
            },
            itemCount: pages.length,
            onPageChanged: (int index) {
              _pageViewNotifier.value = index;
            },
          ),
        ),
        Transform.translate(
          offset: Offset(
              0,
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 100
                  : 100),
          child: Align(
            alignment: Alignment.center,
            child: _displayPageIndicator(
              pages.length,
            ) /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _drawPageIndicators(),
            )*/
            ,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 24.0
                  : 15.0,
              left: myWidth,
              right: myWidth,
            ),
            child: SizedBox(
              //width: MediaQuery.of(context).size.width * .85,
              width: double.infinity,
              height: 50.0,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'GET STARTED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    letterSpacing: 1.0,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      _updateSeen();
                      return HomeScreen();
                    },
                  ));
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
