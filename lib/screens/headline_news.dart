import 'package:flutter/material.dart';
import '../shared_ui/navigation_drawer.dart';
import './home_tabs/favourites.dart';
import './home_tabs/popular.dart';

class HeadLineNews extends StatefulWidget {
  @override
  _HeadLineNewsState createState() => _HeadLineNewsState();
}

class _HeadLineNewsState extends State<HeadLineNews>
    with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
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
        title: Text('Headline News'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          SizedBox(
            width: 5.0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
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
          Favourites(),
          Popular(),
          Favourites(),
        ],
        controller: _tabController,
      ),
    );
  }
}
