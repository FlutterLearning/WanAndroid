import 'package:flutter_app/org/learn/base/list_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class RefreshListViewModel<T> extends ListViewModel<T>{

  RefreshController _refreshController;

  //  默认设置
  bool _enableLoadMore = true;

  bool _enableRefresh = true;

  //  当前设置
  bool _enableLoadMoreState = true;

  bool _enableRefreshState = true;

  RefreshListViewModel({bool enableLoadMore = true, bool enableRefresh = true}){
    this._refreshController = RefreshController(initialRefresh: true);
    this._enableLoadMore = enableLoadMore;
    this._enableRefresh = enableRefresh;
    this._enableLoadMoreState = enableLoadMore;
    this._enableRefreshState = enableRefresh;
  }

  get refreshController => _refreshController;

  get enableLoadMore => _enableLoadMoreState;

  get enableRefresh => _enableRefreshState;

  int _eachListSize = 10;

  set eachListSize(int size) => _eachListSize = size;

  @override
  refresh({bool isRefresh = false}) {
    if(isRefresh && _enableRefresh){
      _enableRefreshState = true;
    }
    super.refresh(isRefresh: isRefresh);
  }

  @override
  void onNewList(List<T> list) {
    if(_enableLoadMore){
      _enableLoadMoreState = list.length >= _eachListSize;
    }
  }

  @override
  void onComplete() {
    if(_refreshController.isLoading){
      _refreshController.loadComplete();
    }else if(_refreshController.isRefresh){
      _refreshController.refreshCompleted();
    }
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }
}