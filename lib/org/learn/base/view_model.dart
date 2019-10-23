import 'package:flutter/widgets.dart';
import 'package:flutter_app/org/learn/base/view_state.dart';

class ViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.INITIAL;

  get viewState => _viewState;

  set viewState(ViewState viewState) {
    this._viewState = viewState;
    notifyListeners();
  }

  void setEmpty() => viewState = ViewState.EMPTY;

  void setLoading() => viewState = ViewState.LOADING;

  void setSuccess() => viewState = ViewState.SUCCESS;

  void setError() => viewState = ViewState.ERROR;

  get isInitial => viewState == ViewState.INITIAL;

  get isLoading => viewState == ViewState.LOADING;

  get isSuccess => viewState == ViewState.SUCCESS;

  get isError => viewState == ViewState.ERROR;

  get isEmpty => viewState == ViewState.EMPTY;
}
