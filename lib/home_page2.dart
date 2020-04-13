import 'package:flutter/material.dart';
import 'package:fluttersliver/refresh_indicator.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  //SliverList
  //SliverGrid
  //SliverPadding
  //SliverAppBar
  //SliverPersistentHeader
  //SliverToBoxAdapter
  //SliverFillViewport
  //SliverFillRemaining

//  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
//    scrollController = ScrollController();
//    scrollController.addListener(() {
//      double max = scrollController.position.maxScrollExtent;
//      double current = scrollController.position.pixels;
//
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NestedScrollView"),
      ),
      body: RefreshIndicator2(
        notificationPredicate: (notifation) {
          return true;
        },
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2), () {
            return true;
          });
        },
        child: NestedScrollView(
          headerSliverBuilder: (contex, _) {
            return [
              //sliver
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          FlutterLogo(),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "作者:Jaynm",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "在普通的ScrollView中，有一组条子（滚动视图的组成部分）。如果这些条中的一个托管了一个TabBarView，它沿相反的方向滚动（例如，允许用户在标签所代表的页面之间水平滑动，而列表则垂直滚动），则TabBarView内部的任何列表都不会与外部ScrollView交互。。例如，浏览内部列表以滚动到顶部不会导致外部ScrollView中的SliverAppBar折叠 而展开。",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              SliverPersistentHeader(
                delegate: MyDelegate(),
                pinned: true,
              ),
            ];
          },
          body: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  "List Tile ${index.toString()}",
                  style: Theme.of(context).textTheme.subtitle,
                ),
              );
            },
            itemCount: 40,
          ),
        ),
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 48,
      padding: EdgeInsets.only(left: 15, right: 15),
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Text(
            "赞：1020",
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            "评论：100",
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "转发：10",
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
