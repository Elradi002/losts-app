import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:losts_app/models/lost_item.dart';
import 'package:dio/dio.dart';

class DioService {
  String errorMessage = '';
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
    try {
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
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        errorMessage = e.response!.data['message'];
      } else if (e.type == DioErrorType.connectTimeout) {
        errorMessage = "Connection timeout";
        print(e.message);
      } else if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = "Receive timeout";
        print(e.message);
      } else if (e.type == DioErrorType.sendTimeout) {
        errorMessage = "Send timeout";
        print(e.message);
      } else {
        errorMessage = "Connection error";
        print(e.message);
      }
      return [];
    }
  }

  // return lost Items
  Future<List<LostItem>> getlost() async {
    final response = await http.get(Uri.parse(lostUrl));
    final extractedData = json.decode(response.body) as List<dynamic>;
    if (extractedData == null) {
      return [];
    }
    // print(extractedData);
    try {
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
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        errorMessage = e.response!.data['message'];
      } else if (e.type == DioErrorType.connectTimeout) {
        errorMessage = "Connection timeout";
        print(e.message);
      } else if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = "Receive timeout";
        print(e.message);
      } else if (e.type == DioErrorType.sendTimeout) {
        errorMessage = "Send timeout";
        print(e.message);
      } else {
        errorMessage = "Connection error";
        print(e.message);
      }
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
      return [];
    }
  }

  Future<void> addFound(LostItem found) async {
    try {
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
      _addFoundFlag = true;
      print('success : ${response.statusCode} added found item successfully');
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        errorMessage = e.response!.data['message'];
        print(e.message);
      } else if (e.type == DioErrorType.connectTimeout) {
        errorMessage = "Connection timeout";
        print(e.message);
      } else if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = "Receive timeout";
        print(e.message);
      } else if (e.type == DioErrorType.sendTimeout) {
        errorMessage = "Send timeout";
        print(e.message);
      } else {
        errorMessage = "Connection error";
        print(e.message);

        // notifyListeners();
      }
    }
  }

  Future<bool> addLost(LostItem lost) async {
    try {
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
      _addLostFlag = true;
      print('success : ${response.statusCode} added lost item successfully');
      //  notifyListeners();
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        errorMessage = e.response!.data['message'];
        return false;
      } else if (e.type == DioErrorType.connectTimeout) {
        errorMessage = "Connection timeout";
        print(e.message);
        return false;
      } else if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = "Receive timeout";
        print(e.message);
        return false;
      } else if (e.type == DioErrorType.sendTimeout) {
        errorMessage = "Send timeout";
        print(e.message);
        return false;
      } else {
        errorMessage = "Connection error";
        print(e.message);
        return false;
      }
    }
  }
  // if (response.statusCode >= 400) {
  //   throw Exception('Error adding lost item ${response.reasonPhrase}');
  // } else if (response.statusCode == 201) {
  //   _addLostFlag = true;
  //   print('success : ${response.statusCode} added lost item successfully');
  //   //  notifyListeners();
  //   return true;
  // }

  Future<bool> checkServerStatus() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:8080/api/V1/Found/server_status'));
      print(response);
      
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        errorMessage = e.response!.data['message'];
        return false;
      } else if (e.type == DioErrorType.connectTimeout) {
        errorMessage = "Connection timeout";
        print(e.message);
        return false;
      } else if (e.type == DioErrorType.receiveTimeout) {
        errorMessage = "Receive timeout";
        print(e.message);
        return false;
      } else if (e.type == DioErrorType.sendTimeout) {
        errorMessage = "Send timeout";
        print(e.message);
        return false;
      } else {
        errorMessage = "Connection error";
        print(e.message);
        return false;
      }
    }
  }
}
