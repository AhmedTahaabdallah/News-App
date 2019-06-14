import 'package:flutter/material.dart';
import '../models/nave_menu.dart';
import '../screens/home_screen.dart';
import '../screens/headline_news.dart';
import '../screens/twitter_feed.dart';
import '../screens/instagram_feed.dart';
import '../screens/facebook_feed.dart';
class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  List<NavMenuItem> navigationMenu = [
    NavMenuItem('Explore', () => HomeScreen(),),
    NavMenuItem('Headline News', () => HeadLineNews(),),
    NavMenuItem(
      'Twitter Feeds',
      () => TwitterFeed(),
    ),
    NavMenuItem(
      'Instagram Feeds',
      () => InstagramFeed(),
    ),
    NavMenuItem(
      'Facebook Feeds',
      () => FaceBookFeed(),
    ),
  ];
  List<String> navMenu = [
    'Explore',
    'Headline News',
    'Read Later',
    'Videos',
    'Photos',
    'Settings',
    'Logout',
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 40),
        itemBuilder: (context, postion) {
          return ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Text(
                    navigationMenu[postion].title,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Visibility(
                    visible: postion == 2 ? true : false,
                    child: postion == 6 || postion == 5
                        ? Container()
                        : Container(
                            width: 50,
                            padding: EdgeInsets.only(
                              top: 2,
                              bottom: 2,
                              right: 2,
                              left: 2,
                            ),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle),
                            child: Text(
                              postion.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            )),
                  )
                ],
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
            ),
            onTap: () {
              /*if(postion == 2){
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context){
          return navigationMenu[postion].destination();
        }));
        } else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return navigationMenu[postion].destination();
        }));        
        }*/
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return navigationMenu[postion].destination();
              }));
            },
          );
        },
        itemCount: navigationMenu.length,
      ),
    );
  }
}
