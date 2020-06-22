import 'package:flutter/cupertino.dart';

class ProductState extends ChangeNotifier {
  bool _inKg = true;

  set inKg(bool value) {
    this._inKg=value;
    notifyListeners();
  }

  bool get inKg{
    return this._inKg;
  }
}
