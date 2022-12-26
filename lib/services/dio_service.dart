import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:losts_app/models/lost_item.dart';

class DioService {
  final List<LostItem> _founds = [];
  List<LostItem> get founds => _founds;
  final List<LostItem> _losts = [];
  List<LostItem> get losts => _losts;
  bool _addFoundFlag = false;
  bool get addFoundFlag => _addFoundFlag;
  bool _addLostFlag = false;
  bool get addLostFlag => _addLostFlag;
  static const String foundUrl = 'http://localhost:8080/api/V1/Found/get_all';
  static const String lostUrl = 'http://localhost:8080/api/V1/Lost/get_all';
  static const String addFoundUrl = 'http://localhost:8080/api/V1/Found/add';
  static const String addLostUrl = 'http://localhost:8080/api/V1/Lost/add';

  Future<List<LostItem>> getFounds() async {
    final response = await http.get(Uri.parse(foundUrl));
    final extractedData = json.decode(response.body) as List<dynamic>;
    if (extractedData == null) {
      return [];
    }
    // print(extractedData);

    extractedData.forEach((itemData) {
      founds.add(LostItem(
        id: itemData['id'].toString(),
        name: itemData['itemName'],
        date: DateTime.parse(itemData['date']),
        type: itemData['itemType'],
        place: itemData['place'],
        phoneNumber: int.parse(itemData['phoneNum']),
        description: itemData['description'],
      ));
    });
    print(founds);
    return founds;
  }

  // return lost Items
  Future<List<LostItem>> getlost() async {
    final response = await http.get(Uri.parse(lostUrl));
    final extractedData = json.decode(response.body) as List<dynamic>;
    if (extractedData == null) {
      return [];
    }
    // print(extractedData);

    extractedData.forEach((itemData) {
      losts.add(LostItem(
        id: itemData['id'].toString(),
        name: itemData['itemName'],
        date: DateTime.parse(itemData['date']),
        type: itemData['itemType'],
        place: itemData['place'],
        phoneNumber: int.parse(itemData['phoneNum']),
        description: itemData['description'],
      ));
    });
    print(losts);
    return losts;
    // extractedData.forEach((itemId, itemData) {
    //   founds.add(LostItem(
    //     id: itemData['id'],
    //     name: itemData['itemName'],
    //     date: DateTime.parse(itemData['date']),
    //     type: itemData['itemType'],
    //     place: itemData['place'],
    //     phoneNumber: itemData['phoneNum'],
    //     description: itemData['description'],

    //   ));
    // });
  }

  Future<void> addFound(LostItem found) async {
    final response = await http.post(
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8	',
      },
      Uri.parse(addFoundUrl),
      //
      //     {
      //     "itemName": "dog",
      //     "itemType": "aniaml",
      //     "place": "khartoum",
      //     "phoneNum": "0966194883",
      //     "description": "lost in khartoum in burri",
      //     "date": "2022-12-22"
      // }
      body: json.encode({
        'itemName': found.name,
        'date': found.date.toIso8601String(),
        'itemType': found.type,
        'place': found.place,
        'phoneNum': found.phoneNumber,
        'description': found.description,
      }),
    );
    if (response.statusCode >= 400) {
      throw Exception('Error adding found item ${response.reasonPhrase}');
    } else if (response.statusCode == 201) {
      _addFoundFlag = true;
      print('success : ${response.statusCode} added found item successfully');
    }
    // notifyListeners();
  }

  Future<bool> addLost(LostItem lost) async {
    final response = await http.post(
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      Uri.parse(addLostUrl),
      body: json.encode({
        'itemName': lost.name,
        'date': lost.date.toIso8601String(),
        'itemType': lost.type,
        'place': lost.place,
        'phoneNum': lost.phoneNumber,
        'description': lost.description,
      }),
    );
    if (response.statusCode >= 400) {
      throw Exception('Error adding lost item ${response.reasonPhrase}');
    } else if (response.statusCode == 201) {
      _addLostFlag = true;
      print('success : ${response.statusCode} added lost item successfully');
      //  notifyListeners();
      return true;
    }
    return false;
  }


  Future<bool> checkServerStatus() async {
    final response = await http
        .get(Uri.parse('http://localhost:8080/api/V1/Found/server_status'));
    print(response);
    if (response.statusCode == 200) {
      print('server is running');
      return true;
    } else {
      return false;
    }
  }
}
