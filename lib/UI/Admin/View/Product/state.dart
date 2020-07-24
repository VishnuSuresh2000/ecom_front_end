import 'package:flutter/cupertino.dart';

class ProductState extends ChangeNotifier {
  ProductState({bool value}) {
    if (value != null) {
      this._inKg = value;
    }
  }
  bool _inKg = true;

  set inKg(bool value) {
    this._inKg = value;
    notifyListeners();
  }

  bool get inKg {
    return this._inKg;
  }
}
