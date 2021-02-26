import 'dart:async';
import 'package:flutter_test_task/src/models/colour_list_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ColourApiProvider {
  /// Get запрос цветов
  Future<ColourListModel> fetchColourList({int pageNumber}) async {
    final _url = "https://reqres.in/api/unknown?page=$pageNumber";
    final response = await http.get(_url, headers: <String, String>{
      'Accept': 'application/json; charset=UTF-8',
    });
    return (response.statusCode == 200)
        ? ColourListModel.fromJson(jsonDecode(response.body))
        : null;
  }
}
