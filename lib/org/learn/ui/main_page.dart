import 'package:flutter/material.dart';
import 'package:flutter_app/org/learn/ui/home_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainState();
  }
}

class MainState extends State<StatefulWidget> with AutomaticKeepAliveClientMixin{
  PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PageView.builder(
        onPageChanged: _pageChange,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          return index == 0 ? HomePage() : new Text("我是第二页");
        },
        itemCount: 2,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        items: [
          BottomNavigationBarItem(icon: new Icon(Icons.category), title: new Text("首页")),
          BottomNavigationBarItem(icon: new Icon(Icons.message), title: new Text("我的")),
        ],
        onTap: (index) =>
            {_pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease)},
      ),
    );
  }

  void _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
