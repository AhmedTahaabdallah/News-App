import 'package:flutter/material.dart';
import '../shared_ui/navigation_drawer.dart';
import './home_tabs/whats_new.dart';
import './home_tabs/popular.dart';
import './home_tabs/favourites.dart';
//import '../api/posts_api.dart';
//import '../models/author.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum PopOutMenu{
  Help,
  About,
  Contact,
  Settings
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
      
  TabController _tabController;
  //PostsApi postsApi = PostsApi();

  Widget _buildPopUpMenu(BuildContext context){
    return PopupMenuButton<PopOutMenu>(itemBuilder: (context) {
      return [
        PopupMenuItem(
          value: PopOutMenu.About,
          child: Text('About'),
        ),
        PopupMenuItem(
          value: PopOutMenu.Contact,
          child: Text('Contact'),
        ),
        PopupMenuItem(
          value: PopOutMenu.Help,
          child: Text('Help'),
        ),
        PopupMenuItem(
          value: PopOutMenu.Settings,
          child: Text('Settings'),
        ),
      ];
    },
    onSelected: (PopOutMenu menu) {

    },
    icon: Icon(Icons.more_vert),);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    //postsApi.fetchWhatsNews();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          _buildPopUpMenu(context),
          SizedBox(
            width: 5.0,
          ),
        ],
        bottom: TabBar(
          tabs: [
            Tab(
              text: "What's New",
            ),
            Tab(
              text: 'Popular',
            ),
            Tab(
              text: 'Favourites',
            ),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
        ),
      ),
      drawer: NavigationDrawer(),
      body: TabBarView(
        children: [
          WhatsNew(),
          Popular(),
          Favourites(),
        ],
        controller: _tabController,
      ),
    );
  }
}
