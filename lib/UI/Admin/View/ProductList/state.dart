import 'package:flutter/cupertino.dart';

class ProductListState extends ChangeNotifier {
  bool _toShow = false;

  set toShow(bool value) {
    this._toShow=value;
    notifyListeners();
  }



  bool get toShow{
    return this._toShow;
  }
}
