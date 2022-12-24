import 'package:flutter/material.dart';
import 'package:losts_app/models/lost_item.dart';
import 'package:losts_app/services/dio_service.dart';

class ItemProvider with ChangeNotifier {
  List<LostItem> _foundItems = [];

  List<LostItem> get foundItems => _foundItems;
  List<LostItem> _lostItems = [];

  List<LostItem> get lostItems => _lostItems;
  bool _addFoundDone = false;
  bool get addFoundDone => _addFoundDone;
  bool _addLostDone = false;
  bool get addLostDone => _addLostDone;


DioService dioService = DioService();

  void getFounds() async {
    _foundItems = await dioService.getFounds();
    notifyListeners();
  }

  void getLosts() async {
    _lostItems = await dioService.getlost();
    notifyListeners();
  }
  void addFound(LostItem item) async {
   await dioService.addFound(item);
   if(dioService.addFoundFlag == true){
     _addFoundDone = true;
      notifyListeners();
   }
    
  }
  void addLost(LostItem item) async {
    await dioService.addLost(item);
    if(dioService.addLostFlag == true){
      _addLostDone = true;
       notifyListeners();
    }
   
  }

  void remove(LostItem item) {
  //  _items.remove(item);
    notifyListeners();
  }
}

