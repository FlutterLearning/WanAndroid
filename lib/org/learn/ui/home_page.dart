import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/org/learn/base/provider/multi_provider.dart';
import 'package:flutter_app/org/learn/model/home_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class HomeState extends State<StatefulWidget> {
  double _appBarHeight = 300;
  AppBarBehavior _appBarBehavior;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider2<HomeBannerModel, HomeArticleModel>(
        model2: HomeArticleModel(),
        model1: HomeBannerModel(),
        builder: (context, bannerModel, articleModel, child) {
          return SmartRefresher(
            controller: articleModel.refreshController,
            enablePullUp: articleModel.enableLoadMore,
            enablePullDown: true,
            onRefresh: () async {
              articleModel.loading(isRefresh: true);
            },
            onLoading: () async {
              articleModel.loading();
            },
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                    expandedHeight: _appBarHeight,
                    pinned: _appBarBehavior == AppBarBehavior.pinned,
                    floating: _appBarBehavior == AppBarBehavior.floating || _appBarBehavior == AppBarBehavior.snapping,
                    snap: _appBarBehavior == AppBarBehavior.snapping,
                    flexibleSpace: HomeBannerWidget(_appBarHeight))
              ],
            ),
          );
        },
      ),
    );
  }
}

class HomeBannerWidget extends StatefulWidget {
  final double _appBarHeight;

  const HomeBannerWidget(this._appBarHeight, {Key key}) : super(key: key);

  @override
  State<HomeBannerWidget> createState() {
    return HomeBannerState();
  }
}

class HomeBannerState extends State<HomeBannerWidget> {
  int _currentPageIndex;
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    HomeBannerModel bannerModel = Provider.of<HomeBannerModel>(context);

    return PageView.builder(
      onPageChanged: _pageChange,
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        return ConstrainedBox(
          constraints: BoxConstraints.expand(height: widget._appBarHeight),
          child: Stack(
            children: <Widget>[
              FadeInImage.memoryNetwork(placeholder: null, image: null),
            ],
          ),
        );
      },
      itemCount: 2,
    );
  }

  void _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }
}
