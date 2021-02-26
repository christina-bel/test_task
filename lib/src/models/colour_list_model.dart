import 'package:flutter_test_task/src/models/colour_model.dart';

/// Класс списка цветов
class ColourListModel {
  int _page;
  int _perPage;
  int _total;
  int _totalPages;

  List<Colour> _data = [];

  ColourListModel.fromJson(Map<String, dynamic> json) {
    _page = json['page'];
    _perPage = json['per_page'];
    _total = json['total'];
    _totalPages = json['total_pages'];

    for (int i = 0; i < json['data'].length; i++) {
      Colour colour = Colour(json['data'][i]);
      _data.add(colour);
    }
  }

  ///  Геттеры приватных свойств списка пользователей
  List<Colour> get data => _data;

  int get totalPages => _totalPages;

  int get totalResults => _total;

  int get perPage => _perPage;

  int get page => _page;
}
