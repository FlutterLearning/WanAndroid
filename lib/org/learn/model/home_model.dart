import 'package:flutter/widgets.dart';
import 'package:flutter_app/org/learn/base/bean/home_article_response.dart';
import 'package:flutter_app/org/learn/base/bean/home_banner_response.dart';
import 'package:flutter_app/org/learn/base/refresh_list_view_model.dart';
import 'package:flutter_app/org/learn/http/api_service.dart';
import 'package:flutter_app/org/learn/http/http.dart';

class HomeBannerModel extends ChangeNotifier {

  List<HomeBannerResponse> _bannerList = List();

  List<HomeBannerResponse> get list => _bannerList;

  Future<List<HomeBannerResponse>> getBannerData() async {
    var response = await HttpRequest.get(ApiService.HOME_BANNER);
    _bannerList = response.map<HomeBannerResponse>((item) => HomeBannerResponse.fromJson(item)).toList();
    notifyListeners();
    return list;
  }
}

class HomeArticleModel extends RefreshListViewModel<ArticleDetailData> {

  HomeArticleModel(){
    startPage = 0;
  }

  @override
  Future<List<ArticleDetailData>> loadData() async{
    var response = await HttpRequest.get(ApiService.HOME_ARTICLE.replaceAll(r"$page", page.toString()));
    return response['datas'].map<ArticleDetailData>((item) => ArticleDetailData.fromJson(item)).toList();
  }
}
