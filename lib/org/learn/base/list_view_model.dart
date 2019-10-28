import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/org/learn/base/view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class ListViewModel<T> extends ViewModel {
  List<T> _list = List();

  int _startPage = 0;

  int _currentPage;

  set startPage(int page) {
    _startPage = page;
    _currentPage = _startPage;
  }

  get page => _currentPage;

  List<T> get list => _list;

  get length => _list.length;

  Future<List<T>> loadData();

  void onNewList(List<T> list) {}

  void onSuccess(List<T> list) {}

  void onError() {}

  void onComplete() {}

  loading({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = _startPage;
    }
    try {
      List<T> result = await loadData();
      onNewList(result);
      if (_currentPage++ == _startPage) {
        _list.clear();
      }
      _list.addAll(result);
      onSuccess(_list);
      if (list.isEmpty) {
        setEmpty();
      } else {
        setSuccess();
      }
    } catch (e) {
      print("Http: ${e.toString()}");
      if (_list.isEmpty) {
        setEmpty();
      } else {
        setError();
      }
      if (e is DioError && e.error is SocketException) {
        Fluttertoast.showToast(msg: "网络异常", toastLength: Toast.LENGTH_SHORT);
      }
      onError();
    }
    onComplete();
  }
}
