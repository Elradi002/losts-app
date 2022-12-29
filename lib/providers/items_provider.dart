import 'package:flutter/material.dart';
import 'package:losts_app/models/lost_item.dart';
import 'package:losts_app/services/dio_service.dart';

class ItemProvider with ChangeNotifier {
  List<LostItem> _foundItems = [];

  List<LostItem> get foundItems => _foundItems;
  List<LostItem> _lostItems = [];
  String errorMessage = '';
  String _isLost = '';
  String get isLost => _isLost;
  String _isFound = '';
  String get isFound => _isFound;
  List<LostItem> get lostItems => _lostItems;
  bool _addFoundDone = false;
  bool get addFoundDone => _addFoundDone;
  bool _addLostDone = false;
  bool get addLostDone => _addLostDone;
  bool _serverLoading = false;
  bool get serverLoading => _serverLoading;
  DioService dioService = DioService();

  Future<void> getFounds() async {
    _foundItems = await dioService.getFounds();
    errorMessage = dioService.errorMessage;
    print("from get founds : $errorMessage");
    notifyListeners();
  }

  Future<void> getLosts() async {
    _lostItems = await dioService.getlost();
    errorMessage = dioService.errorMessage;
    print("from get lost : $errorMessage");

    notifyListeners();
  }

  Future<bool> addFound(LostItem item) async {
    await dioService.addFound(item);
    if (dioService.addFoundFlag == true) {
      _addFoundDone = true;
      errorMessage = dioService.errorMessage;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> addLost(LostItem item) async {
    bool adding = await dioService.addLost(item);
    if (adding) {
      _addLostDone = true;
      errorMessage = dioService.errorMessage;
      return true;
    }
    notifyListeners();
    return false;
  }

  LostItem lostByID(int id) {
    LostItem item = _lostItems.elementAt(id);
    //   _foundItems.elementAt(id);
    //   _lostItems.fold(null, (previousValue, element) {
    //     if (element.id == id) {
    //       return element;
    //     }
    //   });
    _isFound = 'true';
    return item;
  }

  LostItem foundByID(int id) {
    LostItem item = _foundItems.elementAt(id);
    _isLost = 'true';
    return item;
  }

  Future<bool> checkServerStatus() async {
    _serverLoading = true;
    //await Future.delayed(Duration(seconds: 3));
    bool status = await dioService.checkServerStatus();
    if (status == true) {
      await getFounds();
      await getLosts();
      _serverLoading = false;
      print('from provider: $status');
      errorMessage = dioService.errorMessage;
      print("from check server: $errorMessage");
      notifyListeners();
      return true;
    }
    return false;
  }

  void remove(LostItem item) {
    //  _items.remove(item);
    notifyListeners();
  }
}
