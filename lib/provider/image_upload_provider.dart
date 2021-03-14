import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funchat/enum/view_state.dart';

class ImageUploadProvider with ChangeNotifier {
  ViewState viewState = ViewState.IDLE;
  ViewState get  getViewSate => viewState;

  void setToLoading() {
    viewState = ViewState.LOADING;
    notifyListeners();
  }

  void setToIdle() {
    viewState = ViewState.IDLE;
    notifyListeners();
  }
}