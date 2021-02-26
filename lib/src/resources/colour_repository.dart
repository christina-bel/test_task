import 'dart:async';
import 'package:flutter_test_task/src/models/colour_list_model.dart';
import 'package:flutter_test_task/src/resources/colour_api_provider.dart';

class ColourRepository {
  static final ColourRepository _repository = ColourRepository._();

  ColourRepository._();

  factory ColourRepository() {
    return _repository;
  }

  final _colourApiProvider = ColourApiProvider();

  Future<ColourListModel> fetchColours({int pageNumber}) =>
      _colourApiProvider.fetchColourList(pageNumber: pageNumber);
}
