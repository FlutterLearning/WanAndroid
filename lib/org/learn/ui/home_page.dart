import 'package:cached_network_image/cached_network_image.dart';
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
  @override
  Widget build(BuildContext context) {
    double _appBarHeight = MediaQuery.of(context).size.width * 5 / 11;
    return Scaffold(
      body: MultiProvider2<HomeBannerModel, HomeArticleModel>(
        model2: HomeArticleModel(),
        model1: HomeBannerModel(),
        onModelInit: (bannerModel, articleModel) => {bannerModel.getBannerData()},
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
                    floating: false,
                    pinned: true,
                    snap: false,
                    flexibleSpace: HomeBannerWidget(_appBarHeight)),
                SliverPadding(
                  padding: const EdgeInsets.all(10.0),
                  sliver: SliverFixedExtentList(
                    itemExtent: 50.0, //item高度或宽度，取决于滑动方向
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ListTile(
                          title: Text('Item $index'),
                        );
                      },
                      childCount: 30,
                    ),
                  ),
                ),
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
    return FlexibleSpaceBar(
        title: Text("标题"),
        background: PageView.builder(
          onPageChanged: _pageChange,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: <Widget>[
                CachedNetworkImage(
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: bannerModel.list[index].imagePath,
                  placeholder: (context, url) => CircularProgressIndicator(
                     backgroundColor: Colors.pink,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ],
            );
          },
          itemCount: bannerModel.list.length,
        ));
  }

  void _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }
}
